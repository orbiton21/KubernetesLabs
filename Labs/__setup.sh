# This will will spin up minikune, set up the desired namespace

# Start the minikube 
minikube start

# Download latest VS code
curl -fsSL https://code-server.dev/install.sh | sh

# Print out the password so we can use it
cat ~/.config/code-server/config.yaml | grep password:

# Start the VScode in your browser
code-server &




