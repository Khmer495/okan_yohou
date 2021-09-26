package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/field"
)

type Alert struct {
	ent.Schema
}

func (Alert) Mixin() []ent.Mixin {
	return []ent.Mixin{
		UlidMixin{},
		TimeMixin{},
	}
}

// Fields of the Alert.
func (Alert) Fields() []ent.Field {
	return []ent.Field{
		field.String("title"),
		field.Float("lat"),
		field.Float("lon"),
		field.Int("wx").Optional().Nillable(),
		field.Float("temp").Optional().Nillable(),
		field.Int("arpress").Optional().Nillable(),
		field.Int("wndspd").Optional().Nillable(),
		field.Int("rhum").Optional().Nillable(),
		field.Int("feeltmp").Optional().Nillable(),
		field.String("text"),
	}
}

// Edges of the Alert.
func (Alert) Edges() []ent.Edge {
	return nil
}
