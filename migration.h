#ifndef MIGRATION_H
#define MIGRATION_H
#include <QObject>

class QSqlDatabase;
class MigrationPrivate;
class Migration
{
    Q_DECLARE_PRIVATE(Migration)
    Q_DISABLE_COPY(Migration)
public:
    explicit Migration();
    explicit Migration(const QSqlDatabase &db);
    virtual ~Migration();

    void setConnection(const QSqlDatabase &db);
    QSqlDatabase connection() const;
    QStringList files() const;

    virtual bool run(const QStringList &files);
    virtual bool run(const QString &path);
    virtual bool reset(const QStringList &files);
    virtual bool reset(const QString &path);

protected:
    virtual QString table() const;
    virtual bool migrateUp(const QString &file);
    virtual bool migrateDown(const QString &file);
    virtual bool runMigration(const QStringList &files);
    virtual bool rollbackMigration(const QStringList &migrations, const QStringList &files);

    bool toRepository(const QString &migration);
    bool takeRepository(const QString &migration);
    bool createRepository();
    bool repositoryExists();
    int lastBatchNumber();

private:
    QScopedPointer<MigrationPrivate> d_ptr;
};
#endif // MIGRATION_H
