CREATE TABLE [advanced].[CustomerServiceAgg] (
    [AccountId]               NVARCHAR (18) NULL,
    [nmbr_support_tickets]    INT           NULL,
    [total_days_tickets_open] INT           NULL,
    [max_days_ticket_open]    INT           NULL,
    [nmbr_priority_crit_high] INT           NULL,
    [nmbr_priority_med_low]   INT           NULL,
    [nmbr_origin_phone]       INT           NULL,
    [nmbr_origin_other]       INT           NULL,
    [nmbr_support_lvl2]       INT           NULL,
    [nmbr_support_lvl1_lower] INT           NULL,
    [Has_Open_Ticket]         INT           NULL
);

