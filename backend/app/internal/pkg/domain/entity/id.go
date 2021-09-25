package entity

import (
	"math/rand"
	"time"

	"github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"
	"github.com/oklog/ulid/v2"
	"golang.org/x/xerrors"
)

type Id struct {
	ulid ulid.ULID
}

func NewId(val string) (*Id, error) {
	idUlid, err := ulid.ParseStrict(val)
	if err != nil {
		return nil, cerror.NewInvalidArgumentError("idUlid.ParseStrict", "Idの形式が間違っています。")
	}
	id := Id{idUlid}
	return &id, nil
}

var NewUlidFunc = func() ulid.ULID {
	t := time.Now()
	entropy := ulid.Monotonic(rand.New(rand.NewSource(t.UnixNano())), 0)
	return ulid.MustNew(ulid.Timestamp(t), entropy)
}

func InitId() (*Id, error) {
	ulid := NewUlidFunc()
	id, err := NewId(ulid.String())
	if err != nil {
		return nil, xerrors.Errorf("NewId: %w", err)
	}
	return id, nil
}

func (i Id) Ulid() ulid.ULID {
	return i.ulid
}
