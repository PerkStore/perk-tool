import socket
import sys

def scan_ports(ip, ports):
    open_ports = []
    for port in ports:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.settimeout(1)  # Set timeout to 1 second
            result = s.connect_ex((ip, port))
            if result == 0:
                open_ports.append(port)
    return open_ports

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python port_scanner.py <IP_ADDRESS>")
        sys.exit(1)

    ip_address = sys.argv[1].strip()

    # Validate IP address format
    if not (ip_address.count('.') == 3 and all(0 <= int(x) < 256 for x in ip_address.split('.'))):
        print("Invalid IP address format. Please enter a valid IPv4 address.")
        sys.exit(1)

    ports_to_check = [21, 22, 23, 25, 53, 80, 110, 143, 443, 3389]
    print(f"Scanning {ip_address} for open ports...")
    open_ports = scan_ports(ip_address, ports_to_check)

    if open_ports:
        print(f"Open ports on {ip_address}: {', '.join(map(str, open_ports))}")
    else:
        print(f"No open ports found on {ip_address}.")