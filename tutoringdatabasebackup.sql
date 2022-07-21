USE [master]
GO
/****** Object:  Database [TutoringApp]    Script Date: 7/21/2022 5:35:47 PM ******/
CREATE DATABASE [TutoringApp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TutoringApp', FILENAME = N'E:\SQLSERVER\MSSQL15.SQLEXPRESS\MSSQL\DATAPREVIOUS\TutoringApp.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'TutoringApp_log', FILENAME = N'E:\SQLSERVER\MSSQL15.SQLEXPRESS\MSSQL\DATAPREVIOUS\TutoringApp_log.ldf' , SIZE = 3136KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TutoringApp] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TutoringApp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TutoringApp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TutoringApp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TutoringApp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TutoringApp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TutoringApp] SET ARITHABORT OFF 
GO
ALTER DATABASE [TutoringApp] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [TutoringApp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TutoringApp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TutoringApp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TutoringApp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TutoringApp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TutoringApp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TutoringApp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TutoringApp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TutoringApp] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TutoringApp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TutoringApp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TutoringApp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TutoringApp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TutoringApp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TutoringApp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TutoringApp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TutoringApp] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TutoringApp] SET  MULTI_USER 
GO
ALTER DATABASE [TutoringApp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TutoringApp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TutoringApp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TutoringApp] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [TutoringApp] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TutoringApp] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TutoringApp] SET QUERY_STORE = OFF
GO
USE [TutoringApp]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 7/21/2022 5:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[ClassID] [int] IDENTITY(1,1) NOT NULL,
	[TeacherID] [int] NOT NULL,
	[Subject] [varchar](50) NOT NULL,
	[ListOfStudents] [text] NOT NULL,
	[Fee] [float] NOT NULL,
	[Remuneration] [float] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Classes] PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FeeList]    Script Date: 7/21/2022 5:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeeList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClassID] [int] NOT NULL,
	[StudentCode] [varchar](250) NOT NULL,
	[IsPaid] [int] NOT NULL,
 CONSTRAINT [PK_FeeList] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RemunerationList]    Script Date: 7/21/2022 5:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RemunerationList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClassID] [int] NOT NULL,
	[TeacherID] [int] NOT NULL,
	[IsDisbursed] [int] NOT NULL,
 CONSTRAINT [PK_RemunerationList] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 7/21/2022 5:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[StudentCode] [varchar](250) NOT NULL,
	[Fullname] [nvarchar](250) NOT NULL,
	[Birthday] [varchar](50) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NULL,
	[JoinTime] [varchar](15) NOT NULL,
	[Gender] [int] NOT NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[StudentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teachers]    Script Date: 7/21/2022 5:35:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teachers](
	[TeacherID] [int] IDENTITY(1,1) NOT NULL,
	[Fullname] [nvarchar](250) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Specialize] [varchar](50) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Token] [varchar](250) NOT NULL,
	[Password] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Teachers] PRIMARY KEY CLUSTERED 
(
	[TeacherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Classes] ON 
GO
INSERT [dbo].[Classes] ([ClassID], [TeacherID], [Subject], [ListOfStudents], [Fee], [Remuneration], [Status]) VALUES (2, 7, N'Kung Fu', N'SE9BTkcgS0lNIE5BTTE2MzM0OTA3MDE3MDQ=, R3JlbmllIEhpbGFyeTE2MzI4MTQyMTM3NDk=, bWluaCBraG9pMTYzMzM2MzQ5MTY3Mw==, bWluaCBraG9pIGVlMTYzMzM2Mzc2MzIzMA==, dHJhbiB2YW4gdHJ1b25nMTY1MjE1ODI4NDg3Mg==', 4, 7, 1)
GO
INSERT [dbo].[Classes] ([ClassID], [TeacherID], [Subject], [ListOfStudents], [Fee], [Remuneration], [Status]) VALUES (17, 7, N'Modeling', N'dHJhbiB2YW4gdHJ1b25nMTY1MjE1ODI4NDg3Mg==, bWluaCBraG9pMTYzMzM2MzQ5MTY3Mw==, SE9BTkcgS0lNIE5BTTE2MzM0OTA3MDE3MDQ=, TGUgcXVhbmcgeGExNjUyMjYzOTcyODgy, bWluaCBraG9pIGVlMTYzMzM2Mzc2MzIzMA==', 15, 55, 1)
GO
INSERT [dbo].[Classes] ([ClassID], [TeacherID], [Subject], [ListOfStudents], [Fee], [Remuneration], [Status]) VALUES (20, 8, N'Modelling3', N'SE9BTkcgS0lNIE5BTTE2MzM0OTA3MDE3MDQ=, R3JlbmllIEhpbGFyeTE2MzI4MTQyMTM3NDk=, bWluaCBraG9pMTYzMzM2MzQ5MTY3Mw==', 4, 40, 1)
GO
INSERT [dbo].[Classes] ([ClassID], [TeacherID], [Subject], [ListOfStudents], [Fee], [Remuneration], [Status]) VALUES (22, 8, N'Vietnamese', N'R3JlbmllIEhpbGFyeTE2MzI4MTQyMTM3NDk=, bWluaCBraG9pIGVlMTExMTYzMzM2MzU3NDc3Ng==, bWluaCBraG9pMTYzMzM2MzQ5MTY3Mw==', 8, 45, 1)
GO
INSERT [dbo].[Classes] ([ClassID], [TeacherID], [Subject], [ListOfStudents], [Fee], [Remuneration], [Status]) VALUES (23, 3, N'Programming', N'bWluaCBraG9pIGVlMTExMTYzMzM2MzU3NDc3Ng==, bWluaCBraG9pMTYzMzM2MzQ5MTY3Mw==, bWluaCBraG9pIGVlMTYzMzM2Mzc2MzIzMA==', 5, 17, 1)
GO
INSERT [dbo].[Classes] ([ClassID], [TeacherID], [Subject], [ListOfStudents], [Fee], [Remuneration], [Status]) VALUES (24, 8, N'marketing', N'R3JlbmllIEhpbGFyeTE2MzI4MTQyMTM3NDk=, SE9BTkcgS0lNIE5BTTE2MzM0OTA3MDE3MDQ=', 2, 22, 1)
GO
INSERT [dbo].[Classes] ([ClassID], [TeacherID], [Subject], [ListOfStudents], [Fee], [Remuneration], [Status]) VALUES (25, 1009, N'parkour', N'SE9BTkcgS0lNIE5BTTE2MzM0OTA3MDE3MDQ=, TGUgcXVhbmcgeGExNjUyMjYzOTcyODgy, bWluaCBraG9pMTYzMzM2MzQ5MTY3Mw==, R3JlbmllIEhpbGFyeTE2MzI4MTQyMTM3NDk=', 10, 100, 1)
GO
SET IDENTITY_INSERT [dbo].[Classes] OFF
GO
SET IDENTITY_INSERT [dbo].[FeeList] ON 
GO
INSERT [dbo].[FeeList] ([ID], [ClassID], [StudentCode], [IsPaid]) VALUES (5, 20, N'SE9BTkcgS0lNIE5BTTE2MzM0OTA3MDE3MDQ=', 0)
GO
INSERT [dbo].[FeeList] ([ID], [ClassID], [StudentCode], [IsPaid]) VALUES (6, 20, N'R3JlbmllIEhpbGFyeTE2MzI4MTQyMTM3NDk=', 0)
GO
INSERT [dbo].[FeeList] ([ID], [ClassID], [StudentCode], [IsPaid]) VALUES (7, 20, N'bWluaCBraG9pMTYzMzM2MzQ5MTY3Mw==', 0)
GO
INSERT [dbo].[FeeList] ([ID], [ClassID], [StudentCode], [IsPaid]) VALUES (8, 23, N'bWluaCBraG9pIGVlMTExMTYzMzM2MzU3NDc3Ng==', 0)
GO
INSERT [dbo].[FeeList] ([ID], [ClassID], [StudentCode], [IsPaid]) VALUES (9, 23, N'bWluaCBraG9pMTYzMzM2MzQ5MTY3Mw==', 0)
GO
INSERT [dbo].[FeeList] ([ID], [ClassID], [StudentCode], [IsPaid]) VALUES (10, 23, N'bWluaCBraG9pIGVlMTYzMzM2Mzc2MzIzMA==', 0)
GO
INSERT [dbo].[FeeList] ([ID], [ClassID], [StudentCode], [IsPaid]) VALUES (15, 17, N'dHJhbiB2YW4gdHJ1b25nMTY1MjE1ODI4NDg3Mg==', 0)
GO
INSERT [dbo].[FeeList] ([ID], [ClassID], [StudentCode], [IsPaid]) VALUES (16, 17, N'bWluaCBraG9pMTYzMzM2MzQ5MTY3Mw==', 0)
GO
INSERT [dbo].[FeeList] ([ID], [ClassID], [StudentCode], [IsPaid]) VALUES (17, 17, N'SE9BTkcgS0lNIE5BTTE2MzM0OTA3MDE3MDQ=', 0)
GO
INSERT [dbo].[FeeList] ([ID], [ClassID], [StudentCode], [IsPaid]) VALUES (18, 17, N'TGUgcXVhbmcgeGExNjUyMjYzOTcyODgy', 0)
GO
INSERT [dbo].[FeeList] ([ID], [ClassID], [StudentCode], [IsPaid]) VALUES (19, 17, N'bWluaCBraG9pIGVlMTYzMzM2Mzc2MzIzMA==', 0)
GO
SET IDENTITY_INSERT [dbo].[FeeList] OFF
GO
SET IDENTITY_INSERT [dbo].[RemunerationList] ON 
GO
INSERT [dbo].[RemunerationList] ([ID], [ClassID], [TeacherID], [IsDisbursed]) VALUES (1, 1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[RemunerationList] OFF
GO
INSERT [dbo].[Students] ([StudentCode], [Fullname], [Birthday], [Phone], [Email], [JoinTime], [Gender]) VALUES (N'bWluaCBraG9pIGVlMTYzMzM2Mzc2MzIzMA==', N'minh khoi ee', N'10/02/1992', N'6541685', N'minh@khoi.ee', N'1633363763230', 0)
GO
INSERT [dbo].[Students] ([StudentCode], [Fullname], [Birthday], [Phone], [Email], [JoinTime], [Gender]) VALUES (N'bWluaCBraG9pMTYzMzM2MzQ5MTY3Mw==', N'minh khoi', N'10/03/1995', N'5198651', N'minh@khoi.io', N'1633363491673', 0)
GO
INSERT [dbo].[Students] ([StudentCode], [Fullname], [Birthday], [Phone], [Email], [JoinTime], [Gender]) VALUES (N'dHJhbiB2YW4gdHJ1b25nMTY1MjE1ODI4NDg3Mg==', N'tran van truong', N'12/06/1999', N'16516516546', N'truong@yahoo.com.vn', N'1652158284872', 0)
GO
INSERT [dbo].[Students] ([StudentCode], [Fullname], [Birthday], [Phone], [Email], [JoinTime], [Gender]) VALUES (N'R3JlbmllIEhpbGFyeTE2MzI4MTQyMTM3NDk=', N'Grenie Hilary', N'08/08/1986', N'2510556666', N'grenie.hill@night.watch', N'1632814213749', 1)
GO
INSERT [dbo].[Students] ([StudentCode], [Fullname], [Birthday], [Phone], [Email], [JoinTime], [Gender]) VALUES (N'SE9BTkcgS0lNIE5BTTE2MzM0OTA3MDE3MDQ=', N'HOANG KIM NAM', N'11/04/1983', N'65154659', N'kimnam1@jjj.kkk', N'1633490701704', 0)
GO
INSERT [dbo].[Students] ([StudentCode], [Fullname], [Birthday], [Phone], [Email], [JoinTime], [Gender]) VALUES (N'TGUgcXVhbmcgeGExNjUyMjYzOTcyODgy', N'Le quang xa', N'11/05/1985', N'89465198645', N'quanxa@le.gmail', N'1652263972882', 0)
GO
SET IDENTITY_INSERT [dbo].[Teachers] ON 
GO
INSERT [dbo].[Teachers] ([TeacherID], [Fullname], [Phone], [Specialize], [Email], [Token], [Password]) VALUES (3, N'frank master', N'98561206555', N'magic, science', N'frank@master.magic', N'ZnJhbmtAbWFzdGVyLm1hZ2ljZnJhbmsgbWFzdGVy', N'frank master')
GO
INSERT [dbo].[Teachers] ([TeacherID], [Fullname], [Phone], [Specialize], [Email], [Token], [Password]) VALUES (4, N'Jet Li', N'22003639', N'Kung fu, MMA', N'jet.kung.fu@grandmaster.io', N'amV0Lmt1bmcuZnVAZ3JhbmRtYXN0ZXIuaW9KZXQgTGk=', N'Jet Li')
GO
INSERT [dbo].[Teachers] ([TeacherID], [Fullname], [Phone], [Specialize], [Email], [Token], [Password]) VALUES (7, N'donnie yen', N'65326991010', N'wing chun, boxing', N'donnie@wingchun.chinese', N'ZG9ubmllQHdpbmdjaHVuLmNoaW5lc2Vkb25uaWUgeWVu', N'donnie yen')
GO
INSERT [dbo].[Teachers] ([TeacherID], [Fullname], [Phone], [Specialize], [Email], [Token], [Password]) VALUES (8, N'le thi kim ngan', N'65132065316', N'international law, model', N'kimngan@law.hce.org', N'a2ltbmdhbkBsYXcuaGNlLm9yZ2xlIHRoaSBraW0gbmdhbg==', N'le thi kim ngan')
GO
INSERT [dbo].[Teachers] ([TeacherID], [Fullname], [Phone], [Specialize], [Email], [Token], [Password]) VALUES (9, N'le van quang', N'79235808', N'programming, web developing', N'lvquang@gmail', N'bHZxdWFuZ0BnbWFpbGxlIHZhbiBxdWFuZw==', N'le van quang')
GO
INSERT [dbo].[Teachers] ([TeacherID], [Fullname], [Phone], [Specialize], [Email], [Token], [Password]) VALUES (1009, N'Tony jaa', N'98645129', N'muay thai, parkour', N'muay@tony.ja', N'bXVheUB0b255LmphVG9ueSBqYWE=', N'Tony jaa')
GO
SET IDENTITY_INSERT [dbo].[Teachers] OFF
GO
ALTER TABLE [dbo].[Classes] ADD  CONSTRAINT [DF_Classes_ListOfStudents]  DEFAULT ('') FOR [ListOfStudents]
GO
ALTER TABLE [dbo].[Classes] ADD  CONSTRAINT [DF_Classes_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[FeeList] ADD  CONSTRAINT [DF_FeeList_IsPaid]  DEFAULT ((0)) FOR [IsPaid]
GO
ALTER TABLE [dbo].[RemunerationList] ADD  CONSTRAINT [DF_RemunerationList_IsDisbursed]  DEFAULT ((0)) FOR [IsDisbursed]
GO
ALTER TABLE [dbo].[Students] ADD  CONSTRAINT [DF_Students_Gender]  DEFAULT ((0)) FOR [Gender]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A String of StudentCode which seperate to each other with a comma ",". If there is no Student, it will have the value "-1"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Classes', @level2type=N'COLUMN',@level2name=N'ListOfStudents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'"0" mean "Pending" , "1" is "Ongoing", "2" is "Finished"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Classes', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The values are only 0 and 1, correspondingly is "false" and "true"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FeeList', @level2type=N'COLUMN',@level2name=N'IsPaid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The values are only 0 and 1, correspondingly is "false" and "true"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RemunerationList', @level2type=N'COLUMN',@level2name=N'IsDisbursed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'a hash code of (Fullname + JoinTime)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Students', @level2type=N'COLUMN',@level2name=N'StudentCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 is "male", 1 is "female"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Students', @level2type=N'COLUMN',@level2name=N'Gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'hash code of (email + password). It ''s updated automatically when the email or password was changed. It ''s was use when a teacher-user submit any form, so that server can identify the "using user"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Teachers', @level2type=N'COLUMN',@level2name=N'Token'
GO
USE [master]
GO
ALTER DATABASE [TutoringApp] SET  READ_WRITE 
GO
