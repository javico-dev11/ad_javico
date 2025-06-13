
# 🔄 Restablecer la licencia gratuita de AnyDesk

Este script le permite **reiniciar su licencia gratuita de AnyDesk**, eliminando el bloqueo que impide las conexiones a otros dispositivos después de un uso continuo.  
> ⚠️ **Importante**: **no es un crack**. El objetivo es restaurar la funcionalidad de AnyDesk con la licencia gratuita, dentro de los límites de la propia aplicación. Esto no desbloqueará tu AnyDesk permanentemente. Simplemente te permite volver a disfrutar de su uso gratuito sin interrupciones.

> 💡 **Recomendamos fuertemente** Compra una licencia oficial si lo usas con frecuencia o profesionalmente.
> O si lo prefieres, configura tu propio servidor con Rustdesk. ¡Es de código abierto y autoalojado! Descubre cómo instalarlo. <a href="https://github.com/henriquelucas/Rustdesk-Server/tree/main" />haga clic aquí</a>.
---

## ⚙️ Requisitos

- AnyDesk debe estar instalado en la máquina.
- Permisos de administrador (Windows) o `sudo` (Linux) si es necesario.

---

## 💻 Instrucciones de Windows

### ✔️ Método automático (PowerShell)

Ejecute el comando en PowerShell (como administrador):

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/javico-dev11/ad_javico/refs/heads/main/resetAD_Win.cmd?token=GHSAT0AAAAAADDABB3PWBROILNRAKGOH5XW2CMTL2A" -OutFile "resetAD_Win.cmd"; Start-Process "resetAD_Win.cmd"
```

### 🧭 Método manual

1. Descargar el archivo [`resetAD_Win.cmd`](https://raw.githubusercontent.com/javico-dev11/ad_javico/refs/heads/main/resetAD_Win.cmd?token=GHSAT0AAAAAADDABB3PWBROILNRAKGOH5XW2CMTL2A)  
2. Haga clic derecho y seleccione "Ejecutar como administrador".  
3. Espere a que se ejecute el script.  
4. Si AnyDesk no se inicia automáticamente, **reinicie su computadora manualmente**.

---

## 🐧 Instrucciones para Linux

1. Descargar el script:
   ```bash
   wget https://raw.githubusercontent.com/javico-dev11/ad_javico/refs/heads/main/resetAD_Linux.sh?token=GHSAT0AAAAAADDABB3OA47DNUBXTCXJQ3H22CMTOBA
   ```

2. Dar permiso de ejecución:
   ```bash
   chmod +x resetAD_Linux.sh
   ```

3. Ejecutar el script:
   ```bash
   ./resetAD_Linux.sh
   ```

---


