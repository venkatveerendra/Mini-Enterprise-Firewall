# 🛡️ Mini-Enterprise Firewall Setup Demo

This project demonstrates a **basic enterprise-style firewall configuration** using simple rules, diagrams, and test steps. It simulates how a security engineer would protect a small company network with **web, database, and admin zones**.

The demo includes:

* 🔐 Firewall rules (allow, restrict, and deny traffic)
* 🖼️ Network segmentation diagram (DMZ, LAN, Admin)
* 💻 Step-by-step testing guide
* ⚙️ Example configs (Linux iptables + Palo Alto CLI)

---

## 📌 Project Objectives

1. Show how **firewalls secure enterprise networks**.
2. Demonstrate **zone-based segmentation** (Internet, Web, Database, Admin).
3. Provide **practical rule sets** for different scenarios.
4. Teach students how to test allowed vs blocked traffic.

---

## 🖼️ Network Architecture

```
                🌍 Internet
                     |
                 [ Firewall ]
                     |
        ------------------------------
        |             |             |
   DMZ (Web)      Database       Admin LAN
   192.168.1.0    192.168.2.0    192.168.3.0
```

* **DMZ (Web Server Zone):** Public-facing services (HTTP/HTTPS).
* **Database Zone:** Only accessible from Web server.
* **Admin LAN:** Secure management access for admins.
* **Firewall:** Enforces rules between zones.

---

## 📜 Firewall Rules (Example)

| Rule ID | Source         | Destination  | Service      | Action | Description                                 |
| ------- | -------------- | ------------ | ------------ | ------ | ------------------------------------------- |
| 1       | Any (Internet) | Web Server   | HTTP/HTTPS   | Allow  | Allow public access to website              |
| 2       | Web Server     | DB Server    | MySQL (3306) | Allow  | Allow app server to talk to database only   |
| 3       | Admin LAN      | Firewall/All | SSH (22)     | Allow  | Admins can manage firewall and servers      |
| 4       | Any            | Any          | Any          | Deny   | Default deny rule (block all other traffic) |

---

## ⚙️ Example Configurations

### 🔹 Linux iptables

```bash
# Allow HTTP/HTTPS traffic to Web Server
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow Web Server → DB on MySQL
iptables -A FORWARD -s 192.168.1.10 -d 192.168.2.10 -p tcp --dport 3306 -j ACCEPT

# Allow Admin → Firewall SSH
iptables -A INPUT -s 192.168.3.0/24 -p tcp --dport 22 -j ACCEPT

# Block everything else
iptables -A INPUT -j DROP
iptables -A FORWARD -j DROP
```

---

### 🔹 Palo Alto CLI (sample style)

```plaintext
set rulebase security rules "Allow-Web" from "Internet" to "DMZ" application [ web-browsing ssl ] action allow
set rulebase security rules "Allow-DB" from "DMZ" to "Database" application mysql action allow
set rulebase security rules "Allow-Admin" from "Admin" to "Firewall" application ssh action allow
set rulebase security rules "Default-Deny" action deny
```

---

## 🧪 Testing the Setup

1. **Test Allowed Traffic**

   * From Internet → Access web server (`curl http://<webserver-ip>`) ✅
   * From Web Server → Access DB (`mysql -h <db-ip> -u test -p`) ✅
   * From Admin → SSH into firewall (`ssh admin@firewall`) ✅

2. **Test Blocked Traffic**

   * From Internet → Directly connect to DB (`nc <db-ip> 3306`) ❌
   * From Web Server → SSH into Admin PC ❌
   * From Any Zone → Unlisted services ❌

---

## 🚀 How to Run This Demo

1. Create **3 VMs**:

   * Web Server (Ubuntu + Apache)
   * Database Server (MySQL)
   * Admin PC (Linux/Windows)

2. Place them into **different subnets** using VirtualBox/VMware NAT networks.

3. Install firewall (iptables or pfSense).

4. Apply the rules from `firewall_rules.txt`.

5. Test connectivity using `ping`, `curl`, and `mysql` commands.

---

## 📚 Learning Outcomes

* Understand **enterprise firewall basics**.
* Learn to apply **zone-based segmentation**.
* Practice **writing and testing firewall rules**.
* Connect theory (certification knowledge) to practice.

---

## 👨‍💻 About Me

I’m **Ch Veerendra**, a B.Tech CSE student specializing in **Cybersecurity**, currently pursuing the Cyber Security Certification.
This project reflects my interest in becoming a **Cybersecurity Engineer or Network Security Administrator**.

---

🔥 This README will make your repo look like a **professional mini-enterprise firewall demo**, not just a file dump.


