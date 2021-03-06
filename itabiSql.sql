USE [master]
GO
/****** Object:  Database [Travel]    Script Date: 2022/3/25 上午 09:29:22 ******/
CREATE DATABASE [Travel]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Travel', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Travel.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Travel_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Travel_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Travel] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Travel].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Travel] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Travel] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Travel] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Travel] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Travel] SET ARITHABORT OFF 
GO
ALTER DATABASE [Travel] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Travel] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Travel] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Travel] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Travel] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Travel] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Travel] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Travel] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Travel] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Travel] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Travel] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Travel] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Travel] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Travel] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Travel] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Travel] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Travel] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Travel] SET RECOVERY FULL 
GO
ALTER DATABASE [Travel] SET  MULTI_USER 
GO
ALTER DATABASE [Travel] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Travel] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Travel] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Travel] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Travel] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Travel] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Travel', N'ON'
GO
ALTER DATABASE [Travel] SET QUERY_STORE = OFF
GO
USE [Travel]
GO
/****** Object:  Table [dbo].[Articles]    Script Date: 2022/3/25 上午 09:29:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articles](
	[ArticleID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[District] [nvarchar](50) NULL,
	[Longitude] [float] NULL,
	[Latitude] [float] NULL,
	[PlaceID] [varchar](30) NULL,
	[ArticleContent] [nvarchar](max) NULL,
	[CreateTime] [datetime] NOT NULL,
	[UpdateTime] [datetime] NULL,
	[ViewLimit] [int] NOT NULL,
	[CommentLimit] [int] NOT NULL,
 CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED 
(
	[ArticleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Collects]    Script Date: 2022/3/25 上午 09:29:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Collects](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[ArticleID] [uniqueidentifier] NOT NULL,
	[CollectDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Collects] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 2022/3/25 上午 09:29:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[CommentID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[ArticleID] [uniqueidentifier] NOT NULL,
	[CommentContent] [nvarchar](500) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeactivateApplications]    Script Date: 2022/3/25 上午 09:29:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeactivateApplications](
	[ID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[ApplicationDate] [datetime] NOT NULL,
	[DeactContent] [nvarchar](500) NULL,
 CONSTRAINT [PK_DeactivateApplications] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FollowLists]    Script Date: 2022/3/25 上午 09:29:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FollowLists](
	[ID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[FansID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_FollowList] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Likes]    Script Date: 2022/3/25 上午 09:29:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Likes](
	[ID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[ArticleID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Likes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notices]    Script Date: 2022/3/25 上午 09:29:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notices](
	[NotifyID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[ActUserID] [uniqueidentifier] NOT NULL,
	[NotifyType] [int] NOT NULL,
	[ArticleID] [uniqueidentifier] NULL,
	[CreateTime] [datetime] NOT NULL,
	[IsViewed] [bit] NOT NULL,
	[ExpireTime] [datetime] NULL,
 CONSTRAINT [PK_Notifies] PRIMARY KEY CLUSTERED 
(
	[NotifyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pictures]    Script Date: 2022/3/25 上午 09:29:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pictures](
	[PictureID] [uniqueidentifier] NOT NULL,
	[ArticleID] [uniqueidentifier] NOT NULL,
	[PicturePath] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Pictures] PRIMARY KEY CLUSTERED 
(
	[PictureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reporteds]    Script Date: 2022/3/25 上午 09:29:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporteds](
	[ID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[ReportedID] [uniqueidentifier] NOT NULL,
	[ReportDate] [datetime] NOT NULL,
	[Reason] [nvarchar](500) NULL,
 CONSTRAINT [PK_Reporteds] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAccounts]    Script Date: 2022/3/25 上午 09:29:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAccounts](
	[UserID] [uniqueidentifier] NOT NULL,
	[Account] [varchar](15) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[AccountStates] [bit] NOT NULL,
	[PWD] [varchar](64) NOT NULL,
	[PWDkey] [char](5) NOT NULL,
	[DeactivateDate] [datetime] NULL,
	[ProfileContent] [nvarchar](500) NULL,
 CONSTRAINT [PK_UserAccount] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articles] ADD  CONSTRAINT [DF_Article_ArticleID]  DEFAULT (newid()) FOR [ArticleID]
GO
ALTER TABLE [dbo].[Articles] ADD  CONSTRAINT [DF_Article_CreateTime]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[Collects] ADD  CONSTRAINT [DF_Collects_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO
ALTER TABLE [dbo].[Comments] ADD  CONSTRAINT [DF_Messages_MessageID]  DEFAULT (newid()) FOR [CommentID]
GO
ALTER TABLE [dbo].[Comments] ADD  CONSTRAINT [DF_Messages_CreateDate]  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[DeactivateApplications] ADD  CONSTRAINT [DF_DeactivateApplications_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[FollowLists] ADD  CONSTRAINT [DF_FollowLists_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[Likes] ADD  CONSTRAINT [DF_Likes_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[Notices] ADD  CONSTRAINT [DF_Notifies_NotifyID]  DEFAULT (newid()) FOR [NotifyID]
GO
ALTER TABLE [dbo].[Pictures] ADD  CONSTRAINT [DF_Pictures_PictureID]  DEFAULT (newid()) FOR [PictureID]
GO
ALTER TABLE [dbo].[Reporteds] ADD  CONSTRAINT [DF_Reporteds_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[Reporteds] ADD  CONSTRAINT [DF_Reporteds_ReportDate]  DEFAULT (getdate()) FOR [ReportDate]
GO
ALTER TABLE [dbo].[UserAccounts] ADD  CONSTRAINT [DF_UserAccount_UserID]  DEFAULT (newid()) FOR [UserID]
GO
ALTER TABLE [dbo].[UserAccounts] ADD  CONSTRAINT [DF_UserAccount_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Articles]  WITH CHECK ADD  CONSTRAINT [FK_Article_UserAccount] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserAccounts] ([UserID])
GO
ALTER TABLE [dbo].[Articles] CHECK CONSTRAINT [FK_Article_UserAccount]
GO
ALTER TABLE [dbo].[Collects]  WITH CHECK ADD  CONSTRAINT [FK_Collects_Articles] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Articles] ([ArticleID])
GO
ALTER TABLE [dbo].[Collects] CHECK CONSTRAINT [FK_Collects_Articles]
GO
ALTER TABLE [dbo].[Collects]  WITH CHECK ADD  CONSTRAINT [FK_Collects_UserAccounts] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserAccounts] ([UserID])
GO
ALTER TABLE [dbo].[Collects] CHECK CONSTRAINT [FK_Collects_UserAccounts]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Articles] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Articles] ([ArticleID])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Messages_Articles]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Messages_UserAccounts] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserAccounts] ([UserID])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Messages_UserAccounts]
GO
ALTER TABLE [dbo].[DeactivateApplications]  WITH CHECK ADD  CONSTRAINT [FK_DeactivateApplications_UserAccounts] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserAccounts] ([UserID])
GO
ALTER TABLE [dbo].[DeactivateApplications] CHECK CONSTRAINT [FK_DeactivateApplications_UserAccounts]
GO
ALTER TABLE [dbo].[FollowLists]  WITH CHECK ADD  CONSTRAINT [FK_FollowList_UserAccount] FOREIGN KEY([FansID])
REFERENCES [dbo].[UserAccounts] ([UserID])
GO
ALTER TABLE [dbo].[FollowLists] CHECK CONSTRAINT [FK_FollowList_UserAccount]
GO
ALTER TABLE [dbo].[FollowLists]  WITH CHECK ADD  CONSTRAINT [FK_FollowList_UserAccount1] FOREIGN KEY([FansID])
REFERENCES [dbo].[UserAccounts] ([UserID])
GO
ALTER TABLE [dbo].[FollowLists] CHECK CONSTRAINT [FK_FollowList_UserAccount1]
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD  CONSTRAINT [FK_Likes_Articles] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Articles] ([ArticleID])
GO
ALTER TABLE [dbo].[Likes] CHECK CONSTRAINT [FK_Likes_Articles]
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD  CONSTRAINT [FK_Likes_UserAccounts] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserAccounts] ([UserID])
GO
ALTER TABLE [dbo].[Likes] CHECK CONSTRAINT [FK_Likes_UserAccounts]
GO
ALTER TABLE [dbo].[Notices]  WITH CHECK ADD  CONSTRAINT [FK_Notifies_Articles] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Articles] ([ArticleID])
GO
ALTER TABLE [dbo].[Notices] CHECK CONSTRAINT [FK_Notifies_Articles]
GO
ALTER TABLE [dbo].[Notices]  WITH CHECK ADD  CONSTRAINT [FK_Notifies_UserAccounts] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserAccounts] ([UserID])
GO
ALTER TABLE [dbo].[Notices] CHECK CONSTRAINT [FK_Notifies_UserAccounts]
GO
ALTER TABLE [dbo].[Notices]  WITH CHECK ADD  CONSTRAINT [FK_Notifies_UserAccounts1] FOREIGN KEY([ActUserID])
REFERENCES [dbo].[UserAccounts] ([UserID])
GO
ALTER TABLE [dbo].[Notices] CHECK CONSTRAINT [FK_Notifies_UserAccounts1]
GO
ALTER TABLE [dbo].[Pictures]  WITH CHECK ADD  CONSTRAINT [FK_Pictures_Article] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Articles] ([ArticleID])
GO
ALTER TABLE [dbo].[Pictures] CHECK CONSTRAINT [FK_Pictures_Article]
GO
ALTER TABLE [dbo].[Reporteds]  WITH CHECK ADD  CONSTRAINT [FK_Reporteds_UserAccounts] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserAccounts] ([UserID])
GO
ALTER TABLE [dbo].[Reporteds] CHECK CONSTRAINT [FK_Reporteds_UserAccounts]
GO
USE [master]
GO
ALTER DATABASE [Travel] SET  READ_WRITE 
GO
