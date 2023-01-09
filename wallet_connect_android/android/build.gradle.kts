import com.android.build.gradle.BaseExtension

group "io.tokoin.wallet.connect"
version "1.0-SNAPSHOT"

plugins {
    id("com.android.library")
    id("kotlin-android")
}

buildscript {
    repositories {
        google()
        mavenCentral()
        mavenLocal()
        maven(url = "https://plugins.gradle.org/m2/")
    }

    dependencies {
        classpath("com.android.tools.build:gradle:7.3.1")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.7.10")
        classpath("org.jetbrains.dokka:dokka-core:1.6.21")      // TODO: Leave version until AGP 7.3 https://github.com/Kotlin/dokka/issues/2472#issuecomment-1143604232
        classpath("org.jetbrains.dokka:dokka-gradle-plugin:1.6.21")
        classpath("com.squareup.sqldelight:gradle-plugin:1.5.2")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
        mavenLocal()
        maven(url = "https://jitpack.io")
        maven(url = "https://s01.oss.sonatype.org/content/repositories/snapshots/")
        jcenter() // Warning: this repository is going to shut down soon
    }
}

android {
    compileSdk = 31
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    sourceSets.getByName("test") {
        java.srcDir("src/test/kotlin")
    }

}

dependencies {
    implementation(platform("com.walletconnect:android-bom:1.2.0"))
    implementation("com.walletconnect:android-core")
    implementation("com.walletconnect:sign")
}
