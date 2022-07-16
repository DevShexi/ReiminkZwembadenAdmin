class Strings {
  Strings._();

  static const rejectedStatus = "rejected";
  static const pendingStatus = "pending";
  static const approvedStatus = "approved";

  // Login Page
  static const tagline = "zwembaden | wellness | waterfun";
  static const login = "Inloggen";
  static const email = "Email";
  static const password = "Wachtwoord";
  static const resetPassword = "Wachtwoord opnieuw instellen";
  static const close = "Close";
  static const passwordResetLinkSentMessage =
      "Er is een link voor het opnieuw instellen van uw wachtwoord naar uw e-mailadres verzonden:";
  static const passwordResetErrorMessage =
      "Wachtwoord opnieuw instellen is niet voltooid. Controleer uw e-mail of probeer het opnieuw";
  static const invalidResetEmailErrorMessage =
      "Geef een geldig e-mailadres op om uw wachtwoord opnieuw in te stellen";
  static const forgotPassword = "Wachtwoord vergeten?";
  static const passwordRequired = "Een wachtwoord is verplicht";
  static const invalidEmail = "Ongeldig e-mail";
  static const emailRequired = "e-mail is vereist";
  static const atleast6Characters = "Tenminste 6 tekens";
  static const noUserFoundMessage = "Geen gebruiker gevonden voor deze e-mail";
  static const inCorrectPasswordMessage = "je wachtwoord is onjuist";
  static const dontHaveAnAccount = "Heb je geen account?";
  static const registerHere = "Registreer hier";

  // Register Screen
  static const register = "Registreren";
  static const userName = "Gebruikersnaam";
  static const userNameRequired = "username is required";
  static const passwordLengthValidationMessage =
      "Het wachtwoord moet op zijn minst 6 tekens lang zijn";
  static const emailAlreadyInUse = "Op voorwaarde dat e-mail al in gebruik is";
  static const alreadyHaveAnAccount = "Heeft u al een account?";
  static const loginHere = "Hier inloggen";

  //Bottom Nav
  static const clients = "Klanten";
  static const requests = "Verzoeken";
  static const settings = "Instellingen";

  //Clients Screen
  static const logout = "Uitloggen";
  static const cancel = "Annuleren";
  static const logoutPromptMessage =
      "U wordt uitgelogd van de admin-app. Doorgaan?";
  static const rejectedClients = "Afgewezen klanten";
  static const approvedClientType = "approved";
  static const rejectedClientType = "rejected";
  static const requestClientType = "request";
  static const accept = "Aanvaarden";
  static const decline = "Afwijzen";
  static const noClients = "Geen data gevonden";

  //Pools Listing Screen
  static const clientDatabaseConfig = "Configuratie clientdatabase";
  static const noConfigurationsFound = "Geen databaseconfiguraties gevonden";
  static const configure = "Configureren";
  static const hostName = "Hostnaam";
  static const port = "port";
  static const databaseName = "Database naam";
  static const poolDeletedSuccessMessage =
      "Het zwembad is succesvol verwijderd";
  static const poolDeletedErrorMessage =
      "Het zwembad kan niet worden verwijderd";
  static const poolDuplicatedSuccessMessage =
      "De pool is succesvol gedupliceerd";
  static const poolDuplicatedErrorMessage =
      "Het zwembad kan niet worden gedupliceerd";
  static const duplicatedPoolNameErrorMessage =
      "Kan geen dubbele poolnamen/onderwerpen hebben";
  static const poolEditSuccessMessage = "De pool is met succes bewerkt";
  static const poolEditErrorMessage = "Het zwembad kan niet worden bewerkt";

  static const tapPlusToAddPoolMessage =
      "Tik op de knop '+' om een ​​pool voor deze klant toe te voegen";

  //Add Database Config screen
  static const configureDatabase = "Database configureren";
  static const addConnfiguratios = "Configuraties toevoegen";
  static const databaseConfigured = "Database geconfigureerd";

  //Settings Screen
  static const adminSettings = "Beheerdersinstellingen";
  static const addClient = "Klant toevoegen";
  static const sensors = "Sensoren";
  static const addSensor = "Sensor toevoegen";
  static const addPoolSensor = "Zwembadsensoren toevoegen";
  static const add = "toevoegen";

  //Add Pool Screen
  static const labelRetry = "Vernieuwen";
  static const duplicate = "Duplicaat";
  static const continueButton = "Doorgaan";
  static const duplicatePool = "Duplicaat pool";
  static const editPool = "Bewerk pool";
  static const edit = "Bewerk";
  static const delete = "Verwijderen";
  static const maxSelected = "Maximaal geselecteerd";
  static const poolName = "Naam zwembad";
  static const poolTopic = "Zwembad onderwerp";
  static const poolAddedSuccessMessage =
      "Het zwembad is succesvol toegevoegd aan de Firebase";
  static const errorAddingPoolMessage =
      "Er is een fout opgetreden bij het toevoegen van het zwembad.";

  //Add Sensor Screen
  static const sensorName = "Sensornaam";
  static const mqttTopic = "MQTT-onderwerp";
  static const uploadSensorIcon = "Sensorpictogram uploaden";
  static const optional = "(Optioneel)";
  static const maxSensorCount = "Maximaal aantal sensorens";
  static const cropImage = "Afbeelding bijsnijden";
  static const sensorAddedSuccessMessage =
      "De sensor is succesvol toegevoegd aan de Firebase";
  static const sensorUpdatedSuccessMessage = "De sensor is succesvol geüpdatet";
  static const sensorDeletedSuccessMessage =
      "De sensor is succesvol verwijderd";
  static const enableSetValue = "'set' waarde inschakelen";
  static const setTopic = "onderwerp 'set'";
  static const minSet = "Min 'set'";
  static const maxSet = "Max 'set'";
  static const invalidSetValuesError =
      "Geef geldige 'set'-waarden op. min 'set' >= 0 && min 'set' < max 'set'.";

  // Sensor Listing Screen
  static const topic = "onderwerp";
  static const maximumCount = "Max aantal";
  static const newSensor = "nieuwe sensor";
  static const deleteSensor = "Sensor verwijderen";
  static const deleteSensorPromptMessage =
      "De sensor wordt verwijderd. Wil je doorgaan?";
  static const deleteBtnText = "Verwijderen";

  static const emptyFieldValidatorErrorMessage = "Dit veld kan niet leeg zijn";
  static const dummyImage =
      "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60";
}
