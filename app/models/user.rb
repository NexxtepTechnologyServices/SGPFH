class User < ActiveRecord::Base
	belongs_to :affiliate
	enum role: [:"case worker", :reviewer, :administrator]
	after_initialize :set_default_role, :if => :new_record?
	#before_save :set_admin
	validate :set_admin
	validates_presence_of :affiliate, :if => :is_reviewer?, message: "Users of Reviewer type must have an associated Reviewer profile"
	validates :name, :email, presence: true
	validates :password, :password_confirmation, presence: true, on: :create
	validates :password, confirmation: true
	def set_default_role
		self.role ||= :"case worker"
	end
	def set_admin
		self.admin = (self.role == 'administrator')
	end
	def is_reviewer?
		self.role == 'reviewer'
	end
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	#devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
	#devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable
	devise :database_authenticatable, :recoverable, :rememberable, :trackable
end
