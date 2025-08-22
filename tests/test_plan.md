# Test Plan: Mini-Enterprise Firewall Setup

## ✅ Allowed Traffic Tests
| Test ID | Source        | Destination      | Service           | Expected Result |
|---------|---------------|-----------------|-----------------|----------------|
| 1       | Internet      | Web Server      | HTTP/HTTPS       | Connection Successful ✅ |
| 2       | Web Server    | Database Server | MySQL (3306)     | Connection Successful ✅ |
| 3       | Admin LAN     | Firewall        | SSH (22)         | Connection Successful ✅ |

## ❌ Blocked Traffic Tests
| Test ID | Source        | Destination      | Service           | Expected Result |
|---------|---------------|-----------------|-----------------|----------------|
| 4       | Internet      | Database Server | MySQL (3306)     | Connection Blocked ❌ |
| 5       | Web Server    | Admin LAN       | SSH (22)         | Connection Blocked ❌ |
| 6       | Any Zone      | Any Unlisted    | Any              | Connection Blocked ❌ |

## 🖼️ Testing Instructions
1. Open terminal on source machine (Internet VM, Web Server, or Admin PC).
2. Run command for testing:
   - HTTP: `curl http://<webserver-ip>`
   - MySQL: `mysql -h <db-ip> -u test -p`
   - SSH: `ssh admin@<firewall-ip>`
3. Observe success or blocked result.
4. Take screenshots for documentation in `tests/screenshots/`.
