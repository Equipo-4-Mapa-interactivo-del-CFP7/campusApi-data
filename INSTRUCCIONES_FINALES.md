# 🚀 INSTRUCCIONES FINALES - PUSHEAR TODO A CAMPUSAPI-DATA

## PASO 1: DESCARGAR TODOS LOS ARCHIVOS

Descargar desde `/mnt/user-data/outputs/`:

```
📁 Archivos a descargar:
├── SCRIPT_PARA_TU_REPO.sh ← IMPORTANTE
├── JIRA_ISSUE_21_METRICAS.md
├── JIRA_ISSUE_31_EVENTOS.md
├── JIRA_ISSUE_32_ESTRUCTURA.md
├── 31_EVENTOS.feature
└── Pabellon.java
```

---

## PASO 2: COPIAR ARCHIVOS A TU REPO

Copia los 6 archivos al **raíz** de tu repo `campusApi-data`:

```
campusApi-data/
├── SCRIPT_PARA_TU_REPO.sh ← Aquí
├── JIRA_ISSUE_21_METRICAS.md ← Aquí
├── JIRA_ISSUE_31_EVENTOS.md ← Aquí
├── JIRA_ISSUE_32_ESTRUCTURA.md ← Aquí
├── 31_EVENTOS.feature ← Aquí
├── Pabellon.java ← Aquí
├── README.md
├── pom.xml
└── ... (resto del repo)
```

---

## PASO 3: EJECUTAR EL SCRIPT

En terminal, dentro de tu repo:

```bash
cd campusApi-data

bash SCRIPT_PARA_TU_REPO.sh
```

**ESO ES TODO.**

El script:
1. ✅ Verifica que estés en el repo correcto
2. ✅ Crea carpetas necesarias
3. ✅ Copia archivos a lugar correcto
4. ✅ Git add + commit
5. ✅ Git push a GitHub

---

## PASO 4: VERIFICAR EN GITHUB

Después de ~30 segundos, ve a:
```
https://github.com/tu-usuario/campusApi-data
```

Deberías ver:
- ✅ Rama `main` actualizada
- ✅ Nuevo commit: "feat(sprint-1): Data layer..."
- ✅ Nueva carpeta: `docs/sprint-1/` con 3 archivos
- ✅ Nueva carpeta: `src/main/java/com/campusmap/model/` con Pabellon.java
- ✅ Nueva carpeta: `src/test/resources/features/` con 31_EVENTOS.feature

---

## PASO 5: ACTUALIZAR GITHUB ISSUES

Ahora en GitHub, ve a cada issue (#21, #31, #32):

### **Issue #21 (Métricas)**
1. Click en "Edit" (lápiz)
2. Abre el archivo: `docs/sprint-1/21-METRICAS.md`
3. Copia TODO el contenido
4. Pega en la descripción del issue
5. Click "Save"

### **Issue #31 (Eventos)**
1. Click en "Edit"
2. Abre el archivo: `docs/sprint-1/31-EVENTOS.md`
3. Copia TODO
4. Pega en la descripción
5. Click "Save"

### **Issue #32 (Estructura)**
1. Click en "Edit"
2. Abre el archivo: `docs/sprint-1/32-ESTRUCTURA.md`
3. Copia TODO
4. Pega en la descripción
5. Click "Save"

---

## ✅ LISTO PARA MAÑANA

Cuando la mentora pregunte:

**"¿Subieron algo?"**

Tú dices:
```
"Sí. Repos actualizado con:
- 15 métricas completas (conectadas con 4 personas UX)
- 10 eventos core + Gherkin features
- Entity Pabellon base para Backend

Todo en docs/sprint-1/ + src/
GitHub issues #21, #31, #32 listos para validar"
```

---

## 🆘 SI ALGO SALE MAL

### Error: "No estás en un repo Git"
```bash
# Verifica que estés en la carpeta correcta
pwd
# Debería mostrar: .../campusApi-data

# Si no, navega:
cd ../campusApi-data
bash SCRIPT_PARA_TU_REPO.sh
```

### Error: "archivo no encontrado"
```bash
# Verifica que descargaste todos en el raíz
ls -la *.md *.sh *.java *.feature
# Debería listar 6 archivos
```

### Error: "git push falló"
```bash
# Probablemente problema de conexión
# Intenta:
git status
git log -1

# Si falla, revisa:
# 1. Conexión a internet
# 2. Token GitHub (si es necesario)
# 3. Permisos del repo
```

---

## 📊 RESUMEN

| Acción | Archivo | Destino | Status |
|--------|---------|---------|--------|
| 1️⃣ Descargar | SCRIPT_PARA_TU_REPO.sh | Raíz repo | ✅ |
| 2️⃣ Copiar 6 archivos | Todos los .md, .java, .feature | Raíz repo | ✅ |
| 3️⃣ Ejecutar script | bash SCRIPT_PARA_TU_REPO.sh | Terminal | ✅ |
| 4️⃣ Verificar GitHub | Repo actualizado | GitHub | ✅ |
| 5️⃣ Actualizar issues | Copiar contenido | Issues #21,#31,#32 | ✅ |

---

## ⏱️ TIEMPO TOTAL

- Descargar: 2 min
- Copiar a repo: 1 min
- Ejecutar script: <1 min
- Verificar GitHub: 1 min
- Actualizar issues: 5 min

**TOTAL: ~10 minutos**

---

## 🎯 MAÑANA

Repo listo, issues poblados, mentora impresionada. 🚀

