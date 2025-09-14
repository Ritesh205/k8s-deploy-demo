{{/*
Expand the name of the chart.
*/}}
{{- define "k8s-deploy-demo.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "k8s-deploy-demo.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "k8s-deploy-demo.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "k8s-deploy-demo.labels" -}}
helm.sh/chart: {{ include "k8s-deploy-demo.chart" . }}
{{ include "k8s-deploy-demo.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
environment: {{ .Values.environment }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "k8s-deploy-demo.selectorLabels" -}}
app.kubernetes.io/name: {{ include "k8s-deploy-demo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
