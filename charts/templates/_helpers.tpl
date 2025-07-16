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
{{- .Values.app.name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.app.name }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
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
Common labels
*/}}
{{- define "sample-helm-app.labels" -}}
helm.sh/chart: {{ include "sample-helm-app.chart" . }}
{{ include "sample-helm-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sample-helm-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sample-helm-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the namespace to use
*/}}
{{- define "sample-helm-app.namespace" -}}
{{- .Values.namespace.name }}
{{- end }}

{{/*
Environment-specific labels
*/}}
{{- define "sample-helm-app.environmentLabels" -}}
environment: {{ .Values.global.environment }}
{{- end }} 