{{/*
Expand the name of the chart.
*/}}
{{- define "sample-helm-app.name" -}}
{{- default .Chart.Name .Values.app.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sample-helm-app.fullname" -}}
{{- if .Values.app.name }}
{{- printf "%s-%s" .Values.app.name .Values.global.environment | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.app.name }}
{{- if contains $name .Release.Name }}
{{- printf "%s-%s" .Release.Name .Values.global.environment | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-%s" .Release.Name $name .Values.global.environment | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "sample-helm-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels - simplified to use only 'app' label
*/}}
{{- define "sample-helm-app.labels" -}}
app: {{ include "sample-helm-app.fullname" . }}
{{- end }}

{{/*
Selector labels - simplified to use only 'app' label
*/}}
{{- define "sample-helm-app.selectorLabels" -}}
app: {{ include "sample-helm-app.fullname" . }}
{{- end }}

{{/*
Environment-specific labels
*/}}
{{- define "sample-helm-app.environmentLabels" -}}
environment: {{ .Values.global.environment }}
{{- end }} 