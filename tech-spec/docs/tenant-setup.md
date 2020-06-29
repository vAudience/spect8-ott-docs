# Tenant Setup

## Firebase 

The overlay uses Firebase as a data synchronization and authentication hub.

We will setup this instance for you or support you setting up this instance.

For the overlay to work we create a configuration file including Firebase access details. This configuration
file must be made available to the overlay, which is described in any of the "Integration" sections. 


## User Authentication

Our backend servers require some means to identify a user-id and tenant-id for incoming web requests.

For this we discuss with you which kind of token or session data is available in your existing OTT infrastructure,
which can be used to provide user identity.

We will implement a resolution mechanism, which validates and/or parses token or session data provided by you 
to create a Firebase IdToken, which serves as a general authentication token for direct Firebase access or
for subsequent calls to our overlay backend.    
