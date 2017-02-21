dataSource {
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
}

hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}

// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost/trashpoints"
            username = "trashpoints"
            password = "trashpoints"
        }
        hibernate {
            show_sql = false
        }
    }

    test {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost/testtrashpoints"
            username = "trashpoints"
            password = "trashpoints"
        }
    }

    production {
        dataSource {
            dbCreate = "update"
            uri = new URI(System.env.CLEARDB_DATABASE_URL?:"mysql://b5e9766e76d8b2:0bf0b575@us-cdbr-iron-east-04.cleardb.net/heroku_59708ed98b6d28a?reconnect=true")
            url = "jdbc:mysql://" + uri.host + ":" + uri.port + uri.path
            username = uri.userInfo.split(":")[0]
            password = uri.userInfo.split(":")[1]
        }
    }
}