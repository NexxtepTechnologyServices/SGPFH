

class ReportsController < ApplicationController
  def index
  end

  def awards
  	@s = params[:start_date]
  	@e = params[:end_date]
  	@v = params.has_key?(:vendor) ? params[:vendor] : nil
  	@t = params.has_key?(:award_type) ? params[:award_type] : nil

  	conditions = ["date_of_service >= :s", "date_of_service <= :e"]
  	values = {s: @s, e: @e}
  	conditions << "vendor = :v" unless @v.blank?
  	values[:v] = @v unless @v.blank?
  	conditions << "award_type = :t" unless @t.nil? || @t.to_i == 0
  	values[:t] = @t unless @t.nil? || @t.to_i == 0
  	conditions_str = conditions.join(" AND ")
  	@awards = Award.where(conditions_str, values)
  	@sum = @awards.reduce(0) { |s,v| s += v.total_granted }
  end

  def patients
  	
  end

  def awards_to_excel
    s = params[:s]
    e = params[:e]
    v = params.has_key?(:v) ? params[:v] : nil
    t = params.has_key?(:t) ? params[:t] : nil
    awards = search_awards(s,e,v,t)
    logger.error "TESTING #{awards.size}"
    b = Spreadsheet::Workbook.new
    sheet = b.create_worksheet :name => "Awards"
    sheet = build_body( sheet, awards )
    s = StringIO.new
    b.write s
    send_data s.string, :filename => "Awards_report_#{DateTime.now.strftime('%Y-%d-%m')}.xls", :type => "application/vnd.ms-excel"

  end

  private
    def search_awards(s,e,v=nil,t=nil)
      conditions = ["date_of_service >= :s", "date_of_service <= :e"]
      values = {s: s, e: e}
      conditions << "vendor = :v" unless v.blank?
      values[:v] = v unless v.blank?
      conditions << "award_type = :t" unless t.nil? || t.to_i == 0
      values[:t] = t unless t.nil? || t.to_i == 0
      conditions_str = conditions.join(" AND ")
      awards = Award.where(conditions_str, values)
      awards
    end

    def build_body(sheet, data)
      h = [
        "Patient Name",
        "Type",
        "Total Requested",
        "Total Granted",
        "Date Of Service",
        "Created On"
      ]
      h_format = Spreadsheet::Format.new :color => :black, :weight => 'bold'
      sheet.row(0).replace h
      sheet.row(0).default_format = h_format
      i = 1
      data.each do |a|
        r = sheet.row(i)
        d = [
            a.patient.name,
            a.award_type_text,
            a.total_requested,
            a.total_granted,
            a.date_of_service.to_formatted_s(:ld),
            a.created_at.to_formatted_s(:ld)
        ]
        r.replace d
        i += 1
      end
      sheet
    end

end
