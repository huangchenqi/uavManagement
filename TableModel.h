#ifndef TABLEMODEL_H
#define TABLEMODEL_H

#include <QSqlRelationalTableModel>
#include <QQmlParserStatus>

class TableModelPrivate;
class TableModel : public QSqlRelationalTableModel,  public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)
    Q_DECLARE_PRIVATE(TableModel)
    QScopedPointer<TableModelPrivate> d_ptr;
    Q_PROPERTY(QString database READ databaseName WRITE setDatabaseName NOTIFY databaseNameChanged)
    Q_PROPERTY(QString table READ tableName WRITE setTable NOTIFY tableChanged)
    Q_PROPERTY(int selectedRows READ selectedRows NOTIFY selectionChanged)
    Q_PROPERTY(QString errorString READ errorString)
    Q_ENUMS(ItemStatus)
public:
    enum ItemStatus {
        SavedStatus = 0,
        StickedStatus,
        DuplicatedStatus,
        PendingStatus,
        ErrorStatus,
        DeletedStatus
    };

    explicit TableModel(QObject *parent = nullptr);
    ~TableModel() override;

    void classBegin() override;
    void componentComplete() override;

    QHash<int, QByteArray> roleNames() const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;

    void setDatabaseName(const QString &fileName);
    QString databaseName() const;

    void setTable(const QString &tableName) override;
    QString tableName() const;

    int selectedRows() const;

    QString errorString() const;

signals:
    void databaseNameChanged();
    void tableChanged();
    void selectionChanged();
    void error(const QString &message);

public slots:
    bool select() override;
    virtual bool refresh();

    int add();
    int insert(int row);
    bool remove(int row);
    int removeSelected();
    bool recoverRow(int row);
    int recoverSelected();
};

#endif // TABLEMODEL_H
