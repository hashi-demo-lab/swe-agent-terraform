# VSCode Terraform Language Server Integration

This document provides instructions for configuring Visual Studio Code (VSCode) to integrate with the Terraform language server running in a Docker container.

## Prerequisites

- A Docker container running the Terraform language server on port 2087.
- VSCode installed on your system.
- Netcat (`nc`) installed on your system, or an alternative TCP proxy if preferred.

## Docker Setup

1. Build your Docker image with terraform-ls (using your Dockerfile):

   ```bash
   docker build -t my-terraform-ls .
   ```

2. Run the container and map port 2087:

   ```bash
   docker run -d -p 2087:2087 my-terraform-ls
   ```

3. Verify that the language server is running by checking connectivity:

   ```bash
   nc -vz localhost 2087
   ```

## VSCode Configuration

To connect VSCode to the external terraform-ls server, add the following configuration to your VSCode `settings.json` file (you can access it via **Preferences: Open Settings (JSON)**):

```json
{
  "terraform.languageServer": {
    "enabled": true,
    "command": "nc",
    "args": ["localhost", "2087"],
    "trace.server": "verbose"
  },
  "terraform.hover.enabled": true,
  "terraform.validateOnSave": true
}
```

### Explanation:

- The configuration above tells VSCode to use the `nc` (netcat) command as a simple proxy to forward Language Server Protocol (LSP) requests to the terraform-ls server running on `localhost:2087`.
- `trace.server` set to `verbose` will help with debugging by logging detailed information about the LSP communication.
- Additional settings enable hover documentation and validation on file save.

## Alternative Middleware Approach

If you prefer a more robust integration than using `nc`, consider developing a lightweight wrapper (in Node.js, Python, etc.) that establishes a TCP connection with terraform-ls and forwards JSON-RPC messages between VSCode and the server. This wrapper could offer better error handling and logging.

## Troubleshooting

- **No Language Features:**
  - Confirm that terraform-ls is running in your container by checking its logs:
    ```bash
    docker logs <container_id>
    ```
  - Verify that port 2087 is open and accessible from your host machine.

- **Connection Issues:**
  - Check that your Docker container's port mapping is correct.
  - Ensure that no firewall or network settings block the connection.

## Conclusion

Using this setup, VSCode (or any compatible LSP client) can connect to the terraform-ls language server running inside your Docker container, enabling code completion, hover information, validation, and more for your Terraform configurations. 