{{/*
Expand the name of the chart.
*/}}
{{- define "firefly-iii.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "firefly-iii.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
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
{{- define "firefly-iii.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "firefly-iii.labels" -}}
helm.sh/chart: {{ include "firefly-iii.chart" . }}
{{ include "firefly-iii.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "firefly-iii.selectorLabels" -}}
app.kubernetes.io/name: {{ include "firefly-iii.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "firefly-iii.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "firefly-iii.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create the APP_KEY used for encryption, should be random 32 characters.
In order to NOT create a new key for each upgrade a check to the secret is done,
if secret exists, use previous values, if not, create a new key
*/}}
{{- define "firefly-iii.app-key" -}}
  {{- if .Values.secrets.appKey -}}
    {{ include "firefly-iii.validate-app-key" . | required "appKey needs to be exactly 32 characters" }}
  {{- else -}}
    {{- $secret_key := lookup "v1" "Secret" .Release.Namespace (printf "%s-app-key" ( include "firefly-iii.fullname" . )) -}}
    {{- if $secret_key -}}
      {{ $secret_key.data.APP_KEY | b64dec }}
    {{- else -}}
      {{- randAlphaNum 32 | nospace -}}
    {{- end }}
  {{- end }}
{{- end }}

{{/*
Validate if length of APP_KEY is 32 characters
*/}}
{{- define "firefly-iii.validate-app-key" -}}
  {{ $length := len .Values.secrets.appKey }}
  {{- if eq 32 $length -}}
    {{- .Values.secrets.appKey -}}
  {{- end -}}
{{- end -}}
