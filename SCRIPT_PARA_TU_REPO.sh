#!/bin/bash

# =============================================
# SCRIPT PARA CAMPUSAPI-DATA
# Automáticamente copia archivos a tu repo
# y hace push a GitHub
# =============================================

echo "========================================="
echo "🚀 SPRINT 1 SETUP - CAMPUSAPI-DATA"
echo "========================================="
echo ""

# 1. VERIFICAR QUE ESTAMOS EN REPO GIT
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "❌ Error: No estás en un repositorio Git"
  echo "   Ejecuta este script DENTRO de tu repo campusApi-data"
  exit 1
fi

echo "✅ Repo Git detectado: $(git remote get-url origin)"
echo ""

# 2. CREAR CARPETAS
echo "📁 Paso 1: Crear carpetas..."
mkdir -p docs/sprint-1
mkdir -p src/test/resources/features
mkdir -p src/main/java/com/campusmap/model
mkdir -p src/main/java/com/campusmap/repository
echo "✅ Carpetas creadas"
echo ""

# 3. COPIAR ARCHIVOS - MÉTRICAS
echo "📋 Paso 2: Copiar documentación Sprint 1..."

# METRICAS
if [ -f "JIRA_ISSUE_21_METRICAS.md" ]; then
  cp JIRA_ISSUE_21_METRICAS.md docs/sprint-1/21-METRICAS.md
  echo "✅ 21-METRICAS.md"
else
  echo "⚠️  JIRA_ISSUE_21_METRICAS.md no encontrado"
fi

# EVENTOS
if [ -f "JIRA_ISSUE_31_EVENTOS.md" ]; then
  cp JIRA_ISSUE_31_EVENTOS.md docs/sprint-1/31-EVENTOS.md
  echo "✅ 31-EVENTOS.md"
else
  echo "⚠️  JIRA_ISSUE_31_EVENTOS.md no encontrado"
fi

# ESTRUCTURA
if [ -f "JIRA_ISSUE_32_ESTRUCTURA.md" ]; then
  cp JIRA_ISSUE_32_ESTRUCTURA.md docs/sprint-1/32-ESTRUCTURA.md
  echo "✅ 32-ESTRUCTURA.md"
else
  echo "⚠️  JIRA_ISSUE_32_ESTRUCTURA.md no encontrado"
fi

echo ""

# 4. COPIAR GHERKIN FEATURES
echo "📋 Paso 3: Copiar Gherkin features (QA)..."

if [ -f "31_EVENTOS.feature" ]; then
  # Extraer cada feature del archivo
  # (El archivo 31_EVENTOS.feature tiene los 4 features)
  cp 31_EVENTOS.feature src/test/resources/features/
  echo "✅ features (4 scenarios)"
else
  echo "⚠️  31_EVENTOS.feature no encontrado"
fi

echo ""

# 5. COPIAR ENTITIES JAVA
echo "📋 Paso 4: Copiar Entities Java..."

if [ -f "Sector.java" ]; then
  cp Sector.java src/main/java/com/campusmap/model/
  echo "✅ Sector.java"
else
  echo "⚠️  Sector.java no encontrado"
fi

echo ""

# 6. GIT - COMMIT Y PUSH
echo "📊 Paso 5: Git commit y push..."
echo ""

git add docs/sprint-1/ src/

echo "📝 Archivos staged:"
git status --short | grep -E "^\s*A" || echo "   (ninguno)"

echo ""
echo "🔄 Haciendo commit..."

git commit -m "feat(sprint-1): Data layer - Métricas, eventos, entities

- docs/sprint-1/: Documentación Sprint 1 (3 issues)
  * 21-METRICAS.md: 15 KPIs conectadas con personas UX
  * 31-EVENTOS.md: 10 eventos core + tracking
  * 32-ESTRUCTURA.md: 8 entities JPA diseñadas
  
- src/test/resources/features/: Gherkin features (QA)
  * 4 scenarios (paola, maria, federico, camilo)
  
- src/main/java/com/campusmap/model/: Entities
  * Sector.java base para relaciones

Status: READY FOR VALIDATION + CODE
Author: angelgabrieldaq
Date: $(date '+%d May %Y')"

if [ $? -eq 0 ]; then
  echo "✅ Commit exitoso"
else
  echo "⚠️  Commit falló"
  exit 1
fi

echo ""
echo "🚀 Haciendo push a GitHub..."

git push origin main

if [ $? -eq 0 ]; then
  echo "✅ Push exitoso"
else
  echo "❌ Push falló - verifica conexión Git"
  exit 1
fi

echo ""
echo "========================================="
echo "✅ SPRINT 1 SETUP COMPLETADO"
echo "========================================="
echo ""
echo "📍 Archivos copiados:"
echo "   docs/sprint-1/21-METRICAS.md"
echo "   docs/sprint-1/31-EVENTOS.md"
echo "   docs/sprint-1/32-ESTRUCTURA.md"
echo "   src/test/resources/features/"
echo "   src/main/java/com/campusmap/model/Sector.java"
echo ""
echo "🔗 GitHub repo: $(git remote get-url origin)"
echo ""
echo "📌 PRÓXIMO PASO:"
echo "   1. Ir a GitHub Issues (#21, #31, #32)"
echo "   2. Copiar contenido de docs/sprint-1/ a las descripciones"
echo "   3. Validar con mentora"
echo ""
echo "========================================="
