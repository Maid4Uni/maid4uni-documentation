Drop database Maid4Uni

Create database Maid4Uni

use Maid4Uni

Create table Role(
	RoleID varchar(10) not null,
	RoleName nvarchar(20),
	constraint pk_Role primary key (RoleID),
);

Create table Account(
	AccountID varchar(10) not null,
	UserName varchar(30) not null,
	FullName nvarchar(30),
	DateOfBirth date,
	Gender varchar(10),
	PhoneNumber varchar(15),
	Address nvarchar(100),
	Email varchar(50),
	Password varchar(50) not null,
	RoleID varchar(10) not null,
	constraint pk_Account primary key (AccountID),
	constraint fk_RoleAccount foreign key (RoleID) references Role (RoleID)
);

Create table Rating(
	RatingID varchar(20) not null,
	Star decimal(2,1),
	AccountID varchar(10) not null, -- staff
	constraint pk_Rating primary key (RatingID),
	constraint fk_StaffRating foreign key (AccountID) references Account (AccountID)
);

Create table Feedback(
	FeedbackID varchar(20) not null,
	Feedback nvarchar(50),
	AccountID varchar(10) not null, -- staff
	constraint pk_Feedback primary key (FeedbackID),
	constraint fk_StaffFeedback foreign key (AccountID) references Account (AccountID)
);



Create table Service(
	ServiceID varchar(20) not null,
	ServiceName nvarchar(50),
	Description text,
	Price int,
	CreatedAt DATETIME, 
    UpdatedAt DATETIME,
	AccountID varchar(10) not null, -- manager
	constraint pk_Service primary key (ServiceID),
	constraint fk_ManagerService foreign key (AccountID) references Account (AccountID)
);

Create table Package(
	PackageID varchar(20) not null,
	PackageName nvarchar(50),
	Description text,
	Price float,
	NumberOfStaff int,
	CreatedAt datetime,
	UpdatedAt datetime,
	AccountID varchar(10) not null, -- manager
	constraint pk_Package primary key (PackageID),
	constraint fk_ManagerPackage foreign key (AccountID) references Account (AccountID)
);

Create table PackageService(
	PackageID varchar(20) not null,
	ServiceID varchar(20) not null,
	constraint pk_PackageService primary key (PackageID, ServiceID),
	constraint fk_Serice foreign key (ServiceID) references Service (ServiceID),
	constraint fk_Package foreign key (PackageID) references Package (PackageID)
);

Create table Payment(
	PayID varchar(10) not null,
	MethodName nvarchar(30),
	PaymentTime datetime,
	PaymentStatus varchar(10),
	constraint pk_PaymentMethod primary key (PayID)
);

Create table [Order](
	OrderID varchar(10) not null,
	Price float,
	Address TEXT,
	Time datetime,
	Duration int,
	PeriodType int,
	AccountID varchar(10) not null, -- customer
	PackageID varchar(20) not null,
	PayID varchar(10) not null,
	constraint pk_Order primary key (OrderID),
	constraint fk_CustomerOrder foreign key (AccountID) references Account (AccountID),
	constraint fk_PackageOrder foreign key (PackageID) references Package (PackageID),
	constraint fk_PaymentOrder foreign key (PayID) references Payment (PayID),
);

Create table OrderDetail(
	OrderDetailID varchar(10) not null,
	Time datetime,
	StartTime DATETIME,
	EndTime DATETIME,
	Status varchar(10),
	OrderID varchar(10) not null,
	constraint pk_OrderDetail primary key (OrderDetailID),
	constraint fk_OrderOrderDetail foreign key (OrderID) references [Order] (OrderID)
);

Create table Task(
	TaskID varchar(10) not null,
	Status varchar(10),
	OrderDetailID varchar(10) not null,
	ServiceID varchar(20) not null,
	AccountID varchar(10) not null, -- staff
	constraint pk_Task primary key (TaskID),
	constraint fk_OrderDetailTask foreign key (OrderDetailID) references OrderDetail (OrderDetailID),
	constraint fk_ServiceTask foreign key (ServiceID) references Service (ServiceID),
	constraint fk_StaffTask foreign key (AccountID) references Account (AccountID)
);

Create table Tracker(
	TrackerID varchar(10) not null,
	Month tinyint,
	Year int,
	TaskDone int,
	AccountID varchar(10) not null, -- staff
	TaskID varchar(10) not null,
	constraint pk_Tracker primary key (TrackerID),
	constraint fk_StaffTaskTracker foreign key (AccountID) references Account (AccountID),
	constraint fk_TaskTracker foreign key (TaskID) references Task (TaskID)
);



