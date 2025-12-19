import { io } from "socket.io-client";

export const RateConfigKey = "nakoda_bullion";

export function extract() {
    return new Promise((resolve, reject) => {

        const socket = io("https://starlinetechno.in:10001", {
            transports: ["polling"],
            upgrade: false,
            path: "/socket.io",
            allowEIO3: true,
            rejectUnauthorized: false,
            extraHeaders: {
                Origin: "https://nakodabullion.com",
                Referer: "https://nakodabullion.com/",
                "User-Agent": "Mozilla/5.0"
            }
        });

        const timeout = setTimeout(() => {
            socket.disconnect();
            reject(new Error("Timeout waiting for message event"));
        }, 20000);

        socket.on("connect", () => {
            // 🔑 REQUIRED — mirrors browser exactly
            socket.emit("Client", "nakodabullion");
            socket.emit("room", "nakodabullion");
        });

        socket.on("message", (data) => {
            if (!data?.Rate) return;

            clearTimeout(timeout);

            const rates = data.Rate;

            let gold = rates.find(r => r.SymbolId === "103")?.Ask ?? null;
            let silver = rates.find(r => r.SymbolId === "274")?.Ask ?? null;

            silver = parseFloat(silver) || 0;
            silver = silver / 1000;
            gold = parseFloat(gold) || 0;
            gold = gold / 10;

            socket.disconnect();
            resolve([gold, silver]);
        });

        socket.on("connect_error", err => {
            clearTimeout(timeout);
            reject(err);
        });
    });
}
