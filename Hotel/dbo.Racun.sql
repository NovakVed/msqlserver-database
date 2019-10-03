CREATE TABLE [dbo].[Racun] (
    [Id_racuna]      INT      IDENTITY (1000, 1) NOT NULL,
    [Ukupan trošak]  MONEY    NOT NULL,
    [Id_popust]      INT      NULL,
    [Id_zaposlenika] INT      NOT NULL,
    [Datum plačanja] DATETIME NOT NULL,
    [Id_rezervacije] INT NULL, 
    [Id_nacin_placanja] INT NULL, 
    PRIMARY KEY CLUSTERED ([Id_racuna] ASC),
    CONSTRAINT [zaposlenikiFK] FOREIGN KEY ([Id_zaposlenika]) REFERENCES [dbo].[Zaposlenik] ([Id_zaposlenika]),
    CONSTRAINT [popustFK] FOREIGN KEY ([Id_popust]) REFERENCES [dbo].[Popusti] ([Id_popust]),
    CONSTRAINT [CK_Racun_Datum_placanja] CHECK ([Datum plačanja]>=getdate()), 
    CONSTRAINT [nacin_placanjaFK] FOREIGN KEY ([Id_nacin_placanja]) REFERENCES Nacin_placanja(Id_placanja), 
    CONSTRAINT [rezervacijeFK] FOREIGN KEY (Id_rezervacije) REFERENCES Rezervacije(Id_rezervacija)
);

