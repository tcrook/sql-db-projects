﻿CREATE TABLE [dbo].[EV_SF_CONTACT] (
    [ID]                                         NVARCHAR (18)    NULL,
    [ISDELETED]                                  INT              NULL,
    [MASTERRECORDID]                             NVARCHAR (18)    NULL,
    [ACCOUNTID]                                  NVARCHAR (18)    NULL,
    [LASTNAME]                                   NVARCHAR (80)    NULL,
    [FIRSTNAME]                                  NVARCHAR (40)    NULL,
    [SALUTATION]                                 NVARCHAR (40)    NULL,
    [NAME]                                       NVARCHAR (121)   NULL,
    [RECORDTYPEID]                               NVARCHAR (18)    NULL,
    [OTHERSTREET]                                NVARCHAR (255)   NULL,
    [OTHERCITY]                                  NVARCHAR (40)    NULL,
    [OTHERSTATE]                                 NVARCHAR (80)    NULL,
    [OTHERPOSTALCODE]                            NVARCHAR (20)    NULL,
    [OTHERCOUNTRY]                               NVARCHAR (80)    NULL,
    [OTHERLATITUDE]                              DECIMAL (18, 15) NULL,
    [OTHERLONGITUDE]                             DECIMAL (18, 15) NULL,
    [MAILINGSTREET]                              NVARCHAR (255)   NULL,
    [MAILINGCITY]                                NVARCHAR (40)    NULL,
    [MAILINGSTATE]                               NVARCHAR (80)    NULL,
    [MAILINGPOSTALCODE]                          NVARCHAR (20)    NULL,
    [MAILINGCOUNTRY]                             NVARCHAR (80)    NULL,
    [MAILINGLATITUDE]                            DECIMAL (18, 15) NULL,
    [MAILINGLONGITUDE]                           DECIMAL (18, 15) NULL,
    [PHONE]                                      NVARCHAR (40)    NULL,
    [FAX]                                        NVARCHAR (40)    NULL,
    [MOBILEPHONE]                                NVARCHAR (40)    NULL,
    [HOMEPHONE]                                  NVARCHAR (40)    NULL,
    [OTHERPHONE]                                 NVARCHAR (40)    NULL,
    [ASSISTANTPHONE]                             NVARCHAR (40)    NULL,
    [REPORTSTOID]                                NVARCHAR (18)    NULL,
    [EMAIL]                                      NVARCHAR (80)    NULL,
    [TITLE]                                      NVARCHAR (128)   NULL,
    [DEPARTMENT]                                 NVARCHAR (80)    NULL,
    [ASSISTANTNAME]                              NVARCHAR (40)    NULL,
    [LEADSOURCE]                                 NVARCHAR (40)    NULL,
    [BIRTHDATE]                                  DATETIME         NULL,
    [DESCRIPTION]                                NTEXT            NULL,
    [CURRENCYISOCODE]                            NVARCHAR (3)     NULL,
    [OWNERID]                                    NVARCHAR (18)    NULL,
    [HASOPTEDOUTOFEMAIL]                         INT              NULL,
    [DONOTCALL]                                  INT              NULL,
    [CANALLOWPORTALSELFREG]                      INT              NULL,
    [CREATEDDATE]                                DATETIME         NULL,
    [CREATEDBYID]                                NVARCHAR (18)    NULL,
    [LASTMODIFIEDDATE]                           DATETIME         NULL,
    [LASTMODIFIEDBYID]                           NVARCHAR (18)    NULL,
    [SYSTEMMODSTAMP]                             DATETIME         NULL,
    [LASTACTIVITYDATE]                           DATETIME         NULL,
    [LASTCUREQUESTDATE]                          DATETIME         NULL,
    [LASTCUUPDATEDATE]                           DATETIME         NULL,
    [LASTVIEWEDDATE]                             DATETIME         NULL,
    [LASTREFERENCEDDATE]                         DATETIME         NULL,
    [EMAILBOUNCEDREASON]                         NVARCHAR (255)   NULL,
    [EMAILBOUNCEDDATE]                           DATETIME         NULL,
    [ISEMAILBOUNCED]                             INT              NULL,
    [PHOTOURL]                                   NVARCHAR (255)   NULL,
    [JIGSAW]                                     NVARCHAR (20)    NULL,
    [JIGSAWCONTACTID]                            NVARCHAR (20)    NULL,
    [CONNECTIONRECEIVEDID]                       NVARCHAR (18)    NULL,
    [CONNECTIONSENTID]                           NVARCHAR (18)    NULL,
    [MKTO2__INFERRED_CITY__C]                    NVARCHAR (255)   NULL,
    [MKTO2__INFERRED_COMPANY__C]                 NVARCHAR (255)   NULL,
    [MKTO2__INFERRED_COUNTRY__C]                 NVARCHAR (255)   NULL,
    [MKTO2__INFERRED_METROPOLITAN_AREA__C]       NVARCHAR (255)   NULL,
    [MKTO2__INFERRED_PHONE_AREA_CODE__C]         NVARCHAR (255)   NULL,
    [MKTO2__INFERRED_POSTAL_CODE__C]             NVARCHAR (255)   NULL,
    [MKTO2__INFERRED_STATE_REGION__C]            NVARCHAR (255)   NULL,
    [MKTO2__LEAD_SCORE__C]                       DECIMAL (18)     NULL,
    [MKTO2__ORIGINAL_REFERRER__C]                NVARCHAR (255)   NULL,
    [MKTO2__ORIGINAL_SEARCH_ENGINE__C]           NVARCHAR (255)   NULL,
    [MKTO2__ORIGINAL_SEARCH_PHRASE__C]           NVARCHAR (255)   NULL,
    [MKTO2__ORIGINAL_SOURCE_INFO__C]             NVARCHAR (2000)  NULL,
    [MKTO2__ORIGINAL_SOURCE_TYPE__C]             NVARCHAR (255)   NULL,
    [ACCOUNT_STATUS__C]                          NVARCHAR (1300)  NULL,
    [ACCOUNT_SUB_TYPE__C]                        NVARCHAR (1300)  NULL,
    [ACCOUNT_TYPE__C]                            NVARCHAR (1300)  NULL,
    [CRT_POTENTIAL_PARTNER_TYPE__C]              NVARCHAR (100)   NULL,
    [DONOTSOLICIT__C]                            INT              NULL,
    [EVAULT_REPORTS_PASSWORD__C]                 NVARCHAR (128)   NULL,
    [EVAULT_REPORTS_USER_NAME__C]                NVARCHAR (128)   NULL,
    [ID_BACKUP__C]                               NVARCHAR (20)    NULL,
    [IS_PARTNER_CONTACT__C]                      INT              NULL,
    [LRT_CRT__C]                                 NVARCHAR (100)   NULL,
    [MARKETING_CONTACT_TYPE__C]                  NVARCHAR (255)   NULL,
    [MKTO_SI__LAST_INTERESTING_MOMENT_DATE__C]   DATETIME         NULL,
    [MKTO_SI__LAST_INTERESTING_MOMENT_DESC__C]   NVARCHAR (255)   NULL,
    [MKTO_SI__LAST_INTERESTING_MOMENT_SOURCE__C] NVARCHAR (100)   NULL,
    [MKTO_SI__LAST_INTERESTING_MOMENT_TYPE__C]   NVARCHAR (100)   NULL,
    [MKTO_SI__LAST_INTERESTING_MOMENT__C]        NVARCHAR (1300)  NULL,
    [MKTO_SI__PRIORITY__C]                       DECIMAL (18)     NULL,
    [MKTO_SI__RELATIVE_SCORE_VALUE__C]           DECIMAL (4)      NULL,
    [MKTO_SI__RELATIVE_SCORE__C]                 NVARCHAR (1300)  NULL,
    [MKTO_SI__URGENCY_VALUE__C]                  DECIMAL (4)      NULL,
    [MKTO_SI__URGENCY__C]                        NVARCHAR (1300)  NULL,
    [MKTO_SI__VIEW_IN_MARKETO__C]                NVARCHAR (1300)  NULL,
    [SLXID__C]                                   NVARCHAR (25)    NULL,
    [SSN__C]                                     NVARCHAR (4)     NULL,
    [STATUS__C]                                  NVARCHAR (255)   NULL,
    [TYPE__C]                                    NVARCHAR (255)   NULL,
    [EMAIL_OPT_IN__C]                            INT              NULL,
    [ALTERNATE_EMAIL__C]                         NVARCHAR (80)    NULL,
    [DEMOGRAPHIC_SCORE__C]                       DECIMAL (18)     NULL,
    [ORIGINAL_LEAD_SOURCE__C]                    NVARCHAR (255)   NULL,
    [ORIGINAL_LEAD_SOURCE_DETAIL__C]             NVARCHAR (255)   NULL,
    [LEAD_SOURCE_DETAIL__C]                      NVARCHAR (255)   NULL,
    [QBDIALER__DIALS__C]                         DECIMAL (18)     NULL,
    [QBDIALER__LASTCALLTIME__C]                  DATETIME         NULL,
    [QBDIALER__RESPONSETIME__C]                  DECIMAL (18)     NULL,
    [I365_NEWSLETTERS_LIST__C]                   INT              NULL,
    [I365_SPECIAL_OFFERS_LIST__C]                INT              NULL,
    [PARTNER_NEWSLETTERS_LIST__C]                INT              NULL,
    [PARTNER_SPECIAL_OFFERS_LIST__C]             INT              NULL,
    [IS_CUSTOMER_PORTAL_CONTACT__C]              INT              NULL,
    [I__CREATEDFORUSER__C]                       NVARCHAR (18)    NULL,
    [I__OTHEREMAILS__C]                          NVARCHAR (2048)  NULL,
    [HIDDEN_CONVERTED_LEAD__C]                   INT              NULL,
    [ORDER_PORTAL_PASSWORD_SALT__C]              NVARCHAR (255)   NULL,
    [ORDER_PORTAL_PASSWORD__C]                   NVARCHAR (255)   NULL,
    [ORDER_PORTAL_USER_NAME__C]                  NVARCHAR (255)   NULL,
    [CERTIFIED_TO_INSTALL__C]                    NTEXT            NULL,
    [CERTIFIED_TO_SELL__C]                       NTEXT            NULL,
    [CERTIFIED_TO_SUPPORT__C]                    NTEXT            NULL,
    [ENTITLEMENT_COMMENTS__C]                    NTEXT            NULL,
    [MKTO_SI__HIDEDATE__C]                       DATETIME         NULL,
    [MKTO_SI__SALES_INSIGHT__C]                  NVARCHAR (1300)  NULL,
    [SUMMARY_INFORMATION__C]                     NVARCHAR (1000)  NULL,
    [TRAINING_TRACK__C]                          NTEXT            NULL,
    [LEAD_COMMENTS__C]                           NVARCHAR (2500)  NULL,
    [INSTALLATION_CERTIFICATION_COMPLETE__C]     DATETIME         NULL,
    [SALES_CERTIFICATION_COMPLETE__C]            DATETIME         NULL,
    [SE_CERTIFICATION_COMPLETE__C]               DATETIME         NULL,
    [ILT_TRAINING_COMPLETE__C]                   DATETIME         NULL,
    [DEMOS_COMPLETE__C]                          DATETIME         NULL,
    [SALES_CERTIFIED__C]                         DECIMAL (18)     NULL,
    [SE_CERTIFIED__C]                            DECIMAL (18)     NULL,
    [INSTALLATION_CERTIFIED__C]                  DECIMAL (18)     NULL,
    [DAYS_TO_PASS_SALES_CERTIFICATION__C]        DECIMAL (18)     NULL,
    [DAYS_TO_PASS_SE_CERTIFICATION__C]           DECIMAL (18)     NULL,
    [DAYS_TO_PASS_INSTALLATION_CERTIFICATION__C] DECIMAL (18)     NULL,
    [EV_I_TECHNICAL_TRAINING__C]                 DATETIME         NULL,
    [EV_II_TECHNICAL_TRAINING__C]                DATETIME         NULL,
    [EV_I_CERTIFIED__C]                          DECIMAL (18)     NULL,
    [EV_II_CERTIFIED__C]                         DECIMAL (18)     NULL,
    [PASSED_ECTS_ASSESSMENT__C]                  INT              NULL,
    [LAST_CONTACT_PROFILE_UPDATE__C]             DATETIME         NULL,
    [SURVEY_OPT_OUT__C]                          INT              NULL,
    [INSIDEVIEW_ID__C]                           NVARCHAR (18)    NULL,
    [UTM_CAMPAIGN__C]                            NVARCHAR (100)   NULL,
    [UTM_MEDIUM__C]                              NVARCHAR (100)   NULL,
    [UTM_SOURCE__C]                              NVARCHAR (100)   NULL,
    [UTM_TERM__C]                                NVARCHAR (100)   NULL,
    [PARTNER_PORTAL_STATUS__C]                   NVARCHAR (255)   NULL,
    [PARTNER_PORTAL_JOB_FUNCTION__C]             NTEXT            NULL,
    [RELAYWARE_ID__C]                            DECIMAL (18)     NULL,
    [HIDDEN_CONVERTED_LEAD_ID__C]                NVARCHAR (18)    NULL,
    [SUPPORT_STATUS__C]                          NVARCHAR (255)   NULL,
    [WATERFALL_STATUS__C]                        NVARCHAR (255)   NULL,
    [I__DAYSSINCELASTMAIL__C]                    DECIMAL (18)     NULL,
    [I__LASTINBOUNDMAIL__C]                      NVARCHAR (18)    NULL,
    [I__LASTINBOUNDSENT__C]                      DATETIME         NULL,
    [I__LASTINBOUNDTIME__C]                      DATETIME         NULL,
    [I__LASTMAILSENT__C]                         DATETIME         NULL,
    [I__LASTMAILTIMEDELTA__C]                    DECIMAL (18)     NULL,
    [I__LASTMAILTIME__C]                         DATETIME         NULL,
    [I__LASTMAIL__C]                             NVARCHAR (18)    NULL,
    [I__LASTOUTBOUNDMAIL__C]                     NVARCHAR (18)    NULL,
    [I__LASTOUTBOUNDSENT__C]                     DATETIME         NULL,
    [I__LASTOUTBOUNDTIME__C]                     DATETIME         NULL,
    [TECHNICAL_SPECIALIST_CERTIFICATION__C]      DATETIME         NULL,
    [TECHNICAL_SPECIALIST_CERTIFIED__C]          DECIMAL (18)     NULL,
    [HIDDEN_ADMIN_TEXT_FIELD__C]                 NVARCHAR (255)   NULL,
    [NETSUITE_ID__C]                             NVARCHAR (15)    NULL,
    [LATTICE_SCORE__C]                           NVARCHAR (5)     NULL,
    [LATTICE_LEAD_INSIGHT_ONE__C]                DECIMAL (18)     NULL,
    [LATTICE_LEAD_INSIGHT_TWO__C]                DECIMAL (18)     NULL,
    [LATTICE_LEAD_INSIGHT_THREE__C]              DECIMAL (18)     NULL,
    [LATTICE_LEAD_INSIGHT_FOUR__C]               DECIMAL (18)     NULL,
    [LATTICE_LEAD_INSIGHT_FIVE__C]               DECIMAL (18)     NULL,
    [LATTICE_LEAD_SCORE_DATE__C]                 DATETIME         NULL,
    [LINE_OF_BUSINESS__C]                        NVARCHAR (255)   NULL,
    [SURVEY_LAST_DATE__C]                        DATETIME         NULL,
    [QBDIALER__TIMEZONESIDKEY__C]                NVARCHAR (24)    NULL,
    [DO_NOT_CALL_REASON__C]                      NVARCHAR (255)   NULL,
    [CP_LOGIN_URL__C]                            NVARCHAR (1300)  NULL,
    [NETP_SPX__CREATED_BY_SALESPROSPEX__C]       INT              NULL,
    [NETP_SPX__DEDUPEFIRSTLASTCOMPANY__C]        NVARCHAR (1300)  NULL,
    [NETP_SPX__DEDUPEFIRSTLASTEMAILDOMAIN__C]    NVARCHAR (1300)  NULL,
    [NETP_SPX__DEDUPEFIRSTLAST__C]               NVARCHAR (1300)  NULL,
    [NETP_SPX__FACEBOOK_PROFILE__C]              NVARCHAR (255)   NULL,
    [NETP_SPX__JOB_FUNCTION__C]                  NVARCHAR (255)   NULL,
    [NETP_SPX__JOB_LEVEL__C]                     NVARCHAR (255)   NULL,
    [NETP_SPX__LINKEDIN_PROFILE__C]              NVARCHAR (255)   NULL,
    [NETP_SPX__MAILING_COUNTY__C]                NVARCHAR (255)   NULL,
    [NETP_SPX__NETPROSPEX_ID__C]                 NVARCHAR (255)   NULL,
    [NETP_SPX__PHONE_2__C]                       NVARCHAR (40)    NULL,
    [NETP_SPX__TECHPROSPEX__C]                   NVARCHAR (255)   NULL,
    [NETP_SPX__TWITTER_PROFILE__C]               NVARCHAR (255)   NULL,
    [LONG_CONTACT_ID__C]                         NVARCHAR (1300)  NULL,
    [STRIKE_IRON_VALIDATION__C]                  NVARCHAR (255)   NULL,
    [MKTO_SI__ADD_TO_MARKETO_CAMPAIGN__C]        NVARCHAR (1300)  NULL,
    [MKTO_SI__MKTO_LEAD_SCORE__C]                DECIMAL (18)     NULL,
    [CARBONITE_UID__C]                           NVARCHAR (20)    NULL
);


GO
CREATE NONCLUSTERED INDEX [x1609191510763EV_SF_CONTACT_ID]
    ON [dbo].[EV_SF_CONTACT]([ID] ASC);
