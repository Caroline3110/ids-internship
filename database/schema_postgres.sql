CREATE TABLE Role (
    RoleId SERIAL PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL,
    Description VARCHAR(255)
);
CREATE TABLE Category (
    CategoryId SERIAL PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);
CREATE TABLE Priority (
    PriorityId SERIAL PRIMARY KEY,
    PriorityName VARCHAR(50) NOT NULL
);
CREATE TABLE Status (
    StatusId SERIAL PRIMARY KEY,
    StatusName VARCHAR(50) NOT NULL
);
CREATE TABLE "User" (
    UserId SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    RoleId INT NOT NULL,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    CreatedDate TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT FkUser_RoleId FOREIGN KEY (RoleId) REFERENCES Role(RoleId)
);
CREATE TABLE Ticket (
    TicketId SERIAL PRIMARY KEY,
    ReferenceNumber VARCHAR(50) NOT NULL,
    Title VARCHAR(150) NOT NULL,
    Description TEXT NOT NULL,
    CategoryId INT NOT NULL,
    PriorityId INT NOT NULL,
    StatusId INT NOT NULL,
    CreatedByUserId INT NOT NULL,
    AssignedToUserId INT,
    CreatedDate TIMESTAMP NOT NULL DEFAULT NOW(),
    ResolvedDate TIMESTAMP,
    CONSTRAINT FkTicket_CategoryId FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId),
    CONSTRAINT FkTicket_PriorityId FOREIGN KEY (PriorityId) REFERENCES Priority(PriorityId),
    CONSTRAINT FkTicket_StatusId FOREIGN KEY (StatusId) REFERENCES Status(StatusId),
    CONSTRAINT FkTicket_CreatedByUserId FOREIGN KEY (CreatedByUserId) REFERENCES "User"(UserId),
    CONSTRAINT FkTicket_AssignedToUserId FOREIGN KEY (AssignedToUserId) REFERENCES "User"(UserId)
);
CREATE TABLE TicketComment (
    CommentId SERIAL PRIMARY KEY,
    TicketId INT NOT NULL,
    UserId INT NOT NULL,
    CommentText TEXT NOT NULL,
    IsInternal BOOLEAN NOT NULL DEFAULT FALSE,
    CreatedDate TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT FkTicketComment_TicketId FOREIGN KEY (TicketId) REFERENCES Ticket(TicketId),
    CONSTRAINT FkTicketComment_UserId FOREIGN KEY (UserId) REFERENCES "User"(UserId)
);
CREATE TABLE TicketAttachment (
    AttachmentId SERIAL PRIMARY KEY,
    TicketId INT NOT NULL,
    FileName VARCHAR(255) NOT NULL,
    FilePath VARCHAR(500) NOT NULL,
    FileSize INT NOT NULL,
    UploadedDate TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT FkTicketAttachment_TicketId FOREIGN KEY (TicketId) REFERENCES Ticket(TicketId)
);
CREATE TABLE Notification (
    NotificationId SERIAL PRIMARY KEY,
    UserId INT NOT NULL,
    Message VARCHAR(500) NOT NULL,
    IsRead BOOLEAN NOT NULL DEFAULT FALSE,
    CreatedDate TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT FkNotification_UserId FOREIGN KEY (UserId) REFERENCES "User"(UserId)
);
CREATE TABLE ActivityLog (
    LogId SERIAL PRIMARY KEY,
    UserId INT NOT NULL,
    ActionType VARCHAR(100) NOT NULL,
    Description VARCHAR(500) NOT NULL,
    CreatedDate TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT FkActivityLog_UserId FOREIGN KEY (UserId) REFERENCES "User"(UserId)
);
INSERT INTO Role (RoleName, Description) VALUES
    ('Admin', 'Full system access'),
    ('Manager', 'Monitors team tickets and reports'),
    ('IT Support Agent', 'Manages and resolves tickets'),
    ('Employee', 'Creates and tracks tickets');
INSERT INTO Category (CategoryName) VALUES
    ('Hardware'), ('Software'), ('Network'), ('Email'), ('Access Request'), ('Other');
INSERT INTO Priority (PriorityName) VALUES
    ('Low'), ('Medium'), ('High'), ('Critical');
INSERT INTO Status (StatusName) VALUES
    ('Open'), ('In Progress'), ('Pending'), ('Resolved'), ('Closed');
