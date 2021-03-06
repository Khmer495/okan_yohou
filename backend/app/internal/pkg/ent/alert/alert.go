// Code generated by entc, DO NOT EDIT.

package alert

import (
	"time"
)

const (
	// Label holds the string label denoting the alert type in the database.
	Label = "alert"
	// FieldID holds the string denoting the id field in the database.
	FieldID = "id"
	// FieldUlid holds the string denoting the ulid field in the database.
	FieldUlid = "ulid"
	// FieldCreatedAt holds the string denoting the created_at field in the database.
	FieldCreatedAt = "created_at"
	// FieldUpdatedAt holds the string denoting the updated_at field in the database.
	FieldUpdatedAt = "updated_at"
	// FieldDeletedAt holds the string denoting the deleted_at field in the database.
	FieldDeletedAt = "deleted_at"
	// FieldTitle holds the string denoting the title field in the database.
	FieldTitle = "title"
	// FieldLat holds the string denoting the lat field in the database.
	FieldLat = "lat"
	// FieldLon holds the string denoting the lon field in the database.
	FieldLon = "lon"
	// FieldWx holds the string denoting the wx field in the database.
	FieldWx = "wx"
	// FieldTemp holds the string denoting the temp field in the database.
	FieldTemp = "temp"
	// FieldArpress holds the string denoting the arpress field in the database.
	FieldArpress = "arpress"
	// FieldWndspd holds the string denoting the wndspd field in the database.
	FieldWndspd = "wndspd"
	// FieldRhum holds the string denoting the rhum field in the database.
	FieldRhum = "rhum"
	// FieldFeeltmp holds the string denoting the feeltmp field in the database.
	FieldFeeltmp = "feeltmp"
	// FieldText holds the string denoting the text field in the database.
	FieldText = "text"
	// Table holds the table name of the alert in the database.
	Table = "alerts"
)

// Columns holds all SQL columns for alert fields.
var Columns = []string{
	FieldID,
	FieldUlid,
	FieldCreatedAt,
	FieldUpdatedAt,
	FieldDeletedAt,
	FieldTitle,
	FieldLat,
	FieldLon,
	FieldWx,
	FieldTemp,
	FieldArpress,
	FieldWndspd,
	FieldRhum,
	FieldFeeltmp,
	FieldText,
}

// ValidColumn reports if the column name is valid (part of the table columns).
func ValidColumn(column string) bool {
	for i := range Columns {
		if column == Columns[i] {
			return true
		}
	}
	return false
}

var (
	// DefaultCreatedAt holds the default value on creation for the "created_at" field.
	DefaultCreatedAt func() time.Time
	// DefaultUpdatedAt holds the default value on creation for the "updated_at" field.
	DefaultUpdatedAt func() time.Time
	// UpdateDefaultUpdatedAt holds the default value on update for the "updated_at" field.
	UpdateDefaultUpdatedAt func() time.Time
)
