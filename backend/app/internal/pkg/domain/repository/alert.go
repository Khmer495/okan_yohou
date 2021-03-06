//go:generate mockgen -soarce=$GOFILE -destination=mock_$GOFILE -package=$GOPACKAGE
package repository

import (
	"context"
	"fmt"

	"github.com/Khmer495/okan_yohou/internal/pkg/domain/entity"
	"github.com/Khmer495/okan_yohou/internal/pkg/ent"
	"github.com/Khmer495/okan_yohou/internal/pkg/ent/alert"
	"github.com/Khmer495/okan_yohou/internal/pkg/util/cerror"
	"golang.org/x/xerrors"
)

type IAlertRepository interface {
	Create(ctx context.Context, a entity.Alert) error
	One(ctx context.Context, alertId entity.Id) (*entity.Alert, error)
	List(ctx context.Context, limit *int, page *int) (entity.Alerts, error)
	Update(ctx context.Context, a entity.Alert) error
	Delete(ctx context.Context, alertId entity.Id) error
}

type AlertRepository struct {
	mysqlClient *ent.Client
}

func NewAlertRepository() IAlertRepository {
	return AlertRepository{
		mysqlClient: MysqlClient,
	}
}

func (ar AlertRepository) Create(ctx context.Context, a entity.Alert) error {
	now, err := entity.InitDatetime()
	if err != nil {
		return xerrors.Errorf("entity.InitDatetime: %w", err)
	}
	_, err = ar.mysqlClient.Alert.Create().
		SetUlid(a.Id().Ulid().String()).
		SetCreatedAt(now.Time()).
		SetUpdatedAt(now.Time()).
		SetTitle(a.Title()).
		SetLat(a.Lat().Float()).
		SetLon(a.Lon().Float()).
		SetNillableWx(a.PWx().PInt()).
		SetNillableTemp(a.PTemp().PFloat64()).
		SetNillableArpress(a.PArpress().PInt()).
		SetNillableWndspd(a.PWndspd().PInt()).
		SetNillableRhum(a.PRhum().PInt()).
		SetNillableFeeltmp(a.PFeeltmp().PInt()).
		SetText(a.Text()).
		Save(ctx)
	if err != nil {
		return cerror.WrapInternalServerError(err, "ar.mysqlClient.Alert.Create.Save")
	}
	return nil
}

func (ar AlertRepository) One(ctx context.Context, alertId entity.Id) (*entity.Alert, error) {
	a, err := ar.mysqlClient.Alert.Query().Where(
		alert.UlidEQ(alertId.Ulid().String()),
		alert.DeletedAtIsNil(),
	).Only(ctx)
	if err != nil {
		return nil, parseQueryOnlyByUlid(err, "Alert.Query.Only", fmt.Sprintf("alertId: %sのalertが存在しません。", alertId.Ulid().String()))
	}
	alert, err := a.EntityAlert()
	if err != nil {
		return nil, xerrors.Errorf("a.EntityAlert: %w", err)
	}
	return alert, nil
}

func (ar AlertRepository) List(ctx context.Context, limit *int, page *int) (entity.Alerts, error) {
	query := ar.mysqlClient.Alert.Query().
		Where(alert.DeletedAtIsNil())
	if limit != nil {
		query.Limit(*limit)
		if page != nil {
			query.Offset((*page - 1) * *limit)
		}
	}
	alerts, err := query.All(ctx)
	if err != nil {
		return nil, cerror.WrapInternalServerError(err, "ar.mysqlClient.Alert.Query.All")
	}
	entityAlerts, err := ent.Alerts(alerts).NewEntityAlerts()
	if err != nil {
		return nil, xerrors.Errorf("Alerts.NewEntityAlerts: %w", err)
	}
	return entityAlerts, nil
}

func (ar AlertRepository) Update(ctx context.Context, a entity.Alert) error {
	err := func() error {
		tx, err := ar.mysqlClient.Tx(ctx)
		if err != nil {
			return xerrors.Errorf("ar.mysqlClient.Tx: %w", err)
		}
		alert, err := tx.Alert.Query().Where(
			alert.UlidEQ(a.Id().Ulid().String()),
		).Only(ctx)
		if err != nil {
			return txRollbackAndParseError(tx, parseQueryOnlyByUlid(err, "Alert.Query.Only", fmt.Sprintf("alertId: %sのalertが存在しません。", a.Id().Ulid().String())), "Alert.Query.Only")
		}
		_, err = tx.Alert.UpdateOneID(alert.ID).
			SetTitle(a.Title()).
			SetLat(a.Lat().Float()).
			SetLon(a.Lon().Float()).
			SetNillableWx(a.PWx().PInt()).
			SetNillableTemp(a.PTemp().PFloat64()).
			SetNillableArpress(a.PArpress().PInt()).
			SetNillableWndspd(a.PWndspd().PInt()).
			SetNillableRhum(a.PRhum().PInt()).
			SetNillableFeeltmp(a.PFeeltmp().PInt()).
			SetText(a.Text()).
			Save(ctx)
		if err != nil {
			return txRollbackAndParseError(tx, cerror.WrapInternalServerError(err, "Alert.UpdateOneID.Save"), "Alert.UpdateOneID.Save")
		}
		return tx.Commit()
	}()
	if err != nil {
		return newTxCommitError(err)
	}
	return nil
}

func (ar AlertRepository) Delete(ctx context.Context, alertId entity.Id) error {
	err := func() error {
		tx, err := ar.mysqlClient.Tx(ctx)
		if err != nil {
			return xerrors.Errorf("ar.mysqlClient.Tx: %w", err)
		}
		alert, err := tx.Alert.Query().Where(
			alert.UlidEQ(alertId.Ulid().String()),
			alert.DeletedAtIsNil(),
		).Only(ctx)
		if err != nil {
			return txRollbackAndParseError(tx, parseQueryOnlyByUlid(err, "Alert.Query.Only", fmt.Sprintf("alertId: %sのalertが存在しません。", alertId.Ulid().String())), "Alert.Query.Only")
		}
		now, err := entity.InitDatetime()
		if err != nil {
			return txRollbackAndParseError(tx, err, "entity.InitDatetime")
		}
		_, err = tx.Alert.UpdateOneID(alert.ID).
			SetDeletedAt(now.Time()).
			Save(ctx)
		if err != nil {
			return txRollbackAndParseError(tx, cerror.WrapInternalServerError(err, "Alert.UpdateOneID.Save"), "Alert.UpdateOneID.Save")
		}
		return tx.Commit()
	}()
	if err != nil {
		return newTxCommitError(err)
	}
	return nil
}
