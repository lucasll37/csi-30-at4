USE [FI_DW]

GO

CREATE TABLE dim_Admin 
    (
     id_dim_admin INTEGER IDENTITY(1,1) NOT NULL , 
     CNPJAdmin VARCHAR (30) NOT NULL , 
     NameAdmin VARCHAR (200) NOT NULL 
    )
GO

ALTER TABLE dim_Admin ADD CONSTRAINT dim_Admin_PK PRIMARY KEY CLUSTERED (id_dim_admin)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE dim_Auditor 
    (
     id_dim_auditor INTEGER IDENTITY(1,1) NOT NULL , 
     CNPJAuditor VARCHAR (30) NOT NULL , 
     NameAuditor VARCHAR (200) NOT NULL 
    )
GO

ALTER TABLE dim_Auditor ADD CONSTRAINT dim_Auditor_PK PRIMARY KEY CLUSTERED (id_dim_auditor)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE dim_Controller 
    (
     id_dim_controller INTEGER IDENTITY(1,1) NOT NULL , 
     NameController VARCHAR (150) NOT NULL , 
     CNPJController VARCHAR (50) NOT NULL 
    )
GO

ALTER TABLE dim_Controller ADD CONSTRAINT dim_Controller_PK PRIMARY KEY CLUSTERED (id_dim_controller)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE dim_Custodian 
    (
     id_dim_custodian INTEGER IDENTITY(1,1) NOT NULL , 
     CNPJCustodian VARCHAR (30) NOT NULL , 
     NameCustodian VARCHAR (200) NOT NULL 
    )
GO

ALTER TABLE dim_Custodian ADD CONSTRAINT dim_Custodian_PK PRIMARY KEY CLUSTERED (id_dim_custodian)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE dim_Investment_Fund 
    (
     id_fact_investment_fund INTEGER IDENTITY(1,1) NOT NULL , 
     DenomSocial VARCHAR (300) NOT NULL , 
     CNPJ VARCHAR (30) NOT NULL , 
     ClassAMBIMA VARCHAR (100) , 
     DataReg DATE , 
     DataConst DATE , 
     CodCVM INTEGER , 
     Situation VARCHAR (50) NOT NULL , 
     TaxPerfomance DECIMAL (10,2) , 
     TaxAdm DECIMAL (10,2) , 
     Director VARCHAR (100) , 
     FundCotas BIT , 
     FundExclusive BIT , 
     Classe VARCHAR (100) , 
     Condom VARCHAR (100) , 
     RentabFund VARCHAR (100) , 
     TypeFund VARCHAR (100) , 
     TargetAudience VARCHAR (100) 
    )
GO

ALTER TABLE dim_Investment_Fund ADD CONSTRAINT dim_Investment_Fund_PK PRIMARY KEY CLUSTERED (id_fact_investment_fund)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE dim_Manager 
    (
     id_dim_manager INTEGER IDENTITY(1,1) NOT NULL , 
     CPF_CNPJManager VARCHAR (30) NOT NULL , 
     NameJManager VARCHAR (200) NOT NULL , 
     PF_PJ_Manager VARCHAR (2) NOT NULL 
    )
GO

ALTER TABLE dim_Manager ADD CONSTRAINT dim_Manager_PK PRIMARY KEY CLUSTERED (id_dim_manager)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE dim_Time 
    (
     id_dim_time INTEGER IDENTITY(1,1) NOT NULL , 
     datetime DATE NOT NULL , 
     day INTEGER NOT NULL , 
     week INTEGER NOT NULL , 
     month INTEGER NOT NULL , 
     quarter INTEGER NOT NULL , 
     year INTEGER NOT NULL 
    )
GO

ALTER TABLE dim_Time ADD CONSTRAINT dim_Time_PK PRIMARY KEY CLUSTERED (id_dim_time)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE fact_Value 
    (
     id_dim_time INTEGER IDENTITY(1,1) NOT NULL , 
     id_fact_investment_fund INTEGER NOT NULL , 
     id_dim_manager INTEGER NOT NULL , 
     id_dim_admin INTEGER NOT NULL , 
     id_dim_custodian INTEGER NOT NULL , 
     id_dim_auditor INTEGER NOT NULL , 
     id_dim_controller INTEGER NOT NULL , 
     NetWorth DECIMAL (20,2) NOT NULL , 
     Total DECIMAL (20,2) NOT NULL , 
     Quota DECIMAL (6,2) NOT NULL , 
     NQuotaHolders INTEGER NOT NULL 
    )
GO

ALTER TABLE fact_Value ADD CONSTRAINT fact_Value_PK PRIMARY KEY CLUSTERED (id_dim_time, id_fact_investment_fund, id_dim_manager, id_dim_admin, id_dim_custodian, id_dim_auditor, id_dim_controller)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE fact_Value 
    ADD CONSTRAINT fact_Value_dim_Admin_FK FOREIGN KEY 
    ( 
     id_dim_admin
    ) 
    REFERENCES dim_Admin 
    ( 
     id_dim_admin 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE fact_Value 
    ADD CONSTRAINT fact_Value_dim_Auditor_FK FOREIGN KEY 
    ( 
     id_dim_auditor
    ) 
    REFERENCES dim_Auditor 
    ( 
     id_dim_auditor 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE fact_Value 
    ADD CONSTRAINT fact_Value_dim_Controller_FK FOREIGN KEY 
    ( 
     id_dim_controller
    ) 
    REFERENCES dim_Controller 
    ( 
     id_dim_controller 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE fact_Value 
    ADD CONSTRAINT fact_Value_dim_Custodian_FK FOREIGN KEY 
    ( 
     id_dim_custodian
    ) 
    REFERENCES dim_Custodian 
    ( 
     id_dim_custodian 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE fact_Value 
    ADD CONSTRAINT fact_Value_dim_Investment_Fund_FK FOREIGN KEY 
    ( 
     id_fact_investment_fund
    ) 
    REFERENCES dim_Investment_Fund 
    ( 
     id_fact_investment_fund 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE fact_Value 
    ADD CONSTRAINT fact_Value_dim_Manager_FK FOREIGN KEY 
    ( 
     id_dim_manager
    ) 
    REFERENCES dim_Manager 
    ( 
     id_dim_manager 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE fact_Value 
    ADD CONSTRAINT fact_Value_dim_Time_FK FOREIGN KEY 
    ( 
     id_dim_time
    ) 
    REFERENCES dim_Time 
    ( 
     id_dim_time 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO