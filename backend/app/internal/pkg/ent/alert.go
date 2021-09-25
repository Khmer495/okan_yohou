package schema

import "entgo.io/ent"

// Alert holds the schema definition for the Alert entity.
type Alert struct {
	ent.Schema
}

// Fields of the Alert.
func (Alert) Fields() []ent.Field {
	return nil
}

// Edges of the Alert.
func (Alert) Edges() []ent.Edge {
	return nil
}
