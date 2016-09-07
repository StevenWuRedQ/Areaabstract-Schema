IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'datasync')
CREATE LOGIN [datasync] WITH PASSWORD = 'p@ssw0rd'
GO
CREATE USER [datasync] FOR LOGIN [datasync]
GO
GRANT VIEW DEFINITION TO [datasync]
