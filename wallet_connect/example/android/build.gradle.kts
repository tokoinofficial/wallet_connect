buildscript {
    extra["kotlin_version"] = "1.7.10"
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath ("com.android.tools.build:gradle:7.3.1")
        classpath ("org.jetbrains.kotlin:kotlin-gradle-plugin:1.7.10")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

//subprojects {
//    project.buildDir = "${rootProject.buildDir}/${project.name}"
//}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean").configure {
    delete(rootProject.buildDir)
}
