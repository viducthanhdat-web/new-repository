package com.example.jetpackcomposetutorial

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.*
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.KeyboardArrowLeft
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.SpanStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController

/**
 * MainActivity: The entry point for the Android application.
 * Copy this into your Android Studio project (app/src/main/java/com/example/jetpackcomposetutorial/MainActivity.kt)
 */
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            TutorialTheme {
                val navController = rememberNavController()
                NavHost(navController = navController, startDestination = "welcome") {
                    composable("welcome") { WelcomeScreen(navController) }
                    composable("list") { ComponentListScreen(navController) }
                    composable("text") { TextDetailScreen(navController) }
                    composable("images") { ImagesScreen(navController) }
                    composable("textfield") { TextFieldScreen(navController) }
                    composable("column") { ColumnLayoutScreen(navController) }
                    composable("row") { RowLayoutScreen(navController) }
                }
            }
        }
    }
}

@Composable
fun TutorialTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = lightColorScheme(
            primary = Color(0xFF2196F3),
            secondary = Color(0xFF4CAF50),
            tertiary = Color(0xFFFF9800)
        ),
        content = content
    )
}

// --- Welcome Screen ---
@Composable
fun WelcomeScreen(navController: NavController) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.SpaceBetween
    ) {
        Column(
            modifier = Modifier.fillMaxWidth(),
            horizontalAlignment = Alignment.End
        ) {
            Text("Nguyễn Văn A", fontWeight = FontWeight.Bold, fontSize = 14.sp)
            Text("2342312323", color = Color.Gray, fontSize = 12.sp)
        }

        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Box(
                modifier = Modifier
                    .size(120.dp)
                    .rotate(12f)
                    .background(
                        brush = Brush.linearGradient(
                            colors = listOf(Color(0xFF64FFDA), Color(0xFF2196F3), Color(0xFF3F51B5))
                        ),
                        shape = RoundedCornerShape(24.dp)
                    ),
                contentAlignment = Alignment.Center
            ) {
                Box(
                    modifier = Modifier
                        .size(48.dp)
                        .border(4.dp, Color.White.copy(alpha = 0.8f), RoundedCornerShape(12.dp))
                )
            }
            Spacer(modifier = Modifier.height(32.dp))
            Text("Jetpack Compose", fontSize = 24.sp, fontWeight = FontWeight.Bold)
            Spacer(modifier = Modifier.height(16.dp))
            Text(
                "Jetpack Compose is a modern UI toolkit for building native Android applications using a declarative programming approach.",
                textAlign = TextAlign.Center,
                color = Color.DarkGray,
                lineHeight = 20.sp
            )
        }

        Button(
            onClick = { navController.navigate("list") },
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp),
            shape = RoundedCornerShape(16.dp),
            colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF2196F3))
        ) {
            Text("I'm ready", fontWeight = FontWeight.Bold)
        }
    }
}

// --- Component List Screen ---
data class Category(val name: String, val items: List<ComponentItem>)
data class ComponentItem(val title: String, val description: String, val route: String)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ComponentListScreen(navController: NavController) {
    val categories = listOf(
        Category("Display", listOf(
            ComponentItem("Text", "Displays text", "text"),
            ComponentItem("Image", "Displays an image", "images")
        )),
        Category("Input", listOf(
            ComponentItem("TextField", "Input field for text", "textfield")
        )),
        Category("Layout", listOf(
            ComponentItem("Column", "Arranges elements vertically", "column"),
            ComponentItem("Row", "Arranges elements horizontally", "row")
        ))
    )

    Scaffold(
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("UI Components List", color = Color(0xFF2196F3), fontWeight = FontWeight.Bold, fontSize = 18.sp) },
                navigationIcon = {
                    IconButton(onClick = { navController.popBackStack() }) {
                        Icon(Icons.Default.KeyboardArrowLeft, contentDescription = "Back", tint = Color(0xFF2196F3))
                    }
                }
            )
        }
    ) { padding ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(24.dp)
        ) {
            items(categories) { category ->
                Column {
                    Text(category.name, fontWeight = FontWeight.Bold, fontSize = 14.sp, modifier = Modifier.padding(start = 4.dp, bottom = 12.dp))
                    category.items.forEach { item ->
                        Card(
                            onClick = { navController.navigate(item.route) },
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(bottom = 12.dp),
                            shape = RoundedCornerShape(12.dp),
                            colors = CardDefaults.cardColors(containerColor = Color(0xFFE3F2FD))
                        ) {
                            Column(modifier = Modifier.padding(16.dp)) {
                                Text(item.title, fontWeight = FontWeight.Bold, fontSize = 14.sp)
                                Text(item.description, color = Color.Gray, fontSize = 12.sp)
                            }
                        }
                    }
                }
            }
        }
    }
}

// --- Text Detail Screen ---
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun TextDetailScreen(navController: NavController) {
    Scaffold(
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Text Detail", color = Color(0xFF2196F3), fontWeight = FontWeight.Bold) },
                navigationIcon = {
                    IconButton(onClick = { navController.popBackStack() }) {
                        Icon(Icons.Default.KeyboardArrowLeft, contentDescription = "Back", tint = Color(0xFF2196F3))
                    }
                }
            )
        }
    ) { padding ->
        Box(modifier = Modifier.fillMaxSize().padding(padding), contentAlignment = Alignment.Center) {
            Text(
                text = buildAnnotatedString {
                    append("The ")
                    withStyle(style = SpanStyle(fontWeight = FontWeight.Light, fontStyle = FontStyle.Italic)) {
                        append("quick ")
                    }
                    withStyle(style = SpanStyle(color = Color(0xFFFF6F00), fontWeight = FontWeight.Bold)) {
                        append("Brown\n")
                    }
                    append("fox ")
                    withStyle(style = SpanStyle(fontFamily = FontFamily.Monospace, fontSize = 28.sp)) {
                        append("jumps ")
                    }
                    withStyle(style = SpanStyle(fontWeight = FontWeight.ExtraBold, fontStyle = FontStyle.Italic, textDecoration = TextDecoration.Underline)) {
                        append("over\n")
                    }
                    withStyle(style = SpanStyle(textDecoration = TextDecoration.Underline)) {
                        append("the")
                    }
                    append(" ")
                    withStyle(style = SpanStyle(fontFamily = FontFamily.Serif, fontStyle = FontStyle.Italic, fontSize = 28.sp)) {
                        append("lazy ")
                    }
                    withStyle(style = SpanStyle(fontWeight = FontWeight.Bold)) {
                        append("dog.")
                    }
                },
                fontSize = 32.sp,
                textAlign = TextAlign.Center,
                lineHeight = 40.sp
            )
        }
    }
}

// --- Images Screen ---
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ImagesScreen(navController: NavController) {
    Scaffold(
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Images", color = Color(0xFF2196F3), fontWeight = FontWeight.Bold) },
                navigationIcon = {
                    IconButton(onClick = { navController.popBackStack() }) {
                        Icon(Icons.Default.KeyboardArrowLeft, contentDescription = "Back", tint = Color(0xFF2196F3))
                    }
                }
            )
        }
    ) { padding ->
        Column(modifier = Modifier.fillMaxSize().padding(padding).padding(24.dp).verticalScroll(rememberScrollState())) {
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                Box(
                    modifier = Modifier.fillMaxWidth().aspectRatio(4/3f).clip(RoundedCornerShape(16.dp)).background(Color(0xFFF5F5F5)),
                    contentAlignment = Alignment.Center
                ) {
                    Text("Network Image Placeholder", color = Color.Gray, fontSize = 12.sp)
                }
                Spacer(modifier = Modifier.height(8.dp))
                Text("https://example.com/logo.png", color = Color.Blue, textDecoration = TextDecoration.Underline, fontSize = 10.sp, textAlign = TextAlign.Center)
            }
            Spacer(modifier = Modifier.height(32.dp))
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                Box(
                    modifier = Modifier.fillMaxWidth().aspectRatio(4/3f).clip(RoundedCornerShape(16.dp)).background(Color(0xFFEEEEEE)),
                    contentAlignment = Alignment.Center
                ) {
                    Text("Asset Image Placeholder", color = Color.Gray, fontSize = 12.sp)
                }
                Spacer(modifier = Modifier.height(8.dp))
                Text("In app", color = Color.Gray, fontSize = 12.sp)
            }
        }
    }
}

// --- TextField Screen ---
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun TextFieldScreen(navController: NavController) {
    var text by remember { mutableStateOf("") }
    Scaffold(
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("TextField", color = Color(0xFF2196F3), fontWeight = FontWeight.Bold) },
                navigationIcon = {
                    IconButton(onClick = { navController.popBackStack() }) {
                        Icon(Icons.Default.KeyboardArrowLeft, contentDescription = "Back", tint = Color(0xFF2196F3))
                    }
                }
            )
        }
    ) { padding ->
        Column(modifier = Modifier.fillMaxSize().padding(padding).padding(32.dp)) {
            Text("Normal Text Field", fontSize = 12.sp, fontWeight = FontWeight.Bold, color = Color.Gray, modifier = Modifier.padding(start = 4.dp, bottom = 8.dp))
            OutlinedTextField(
                value = text,
                onValueChange = { text = it },
                modifier = Modifier.fillMaxWidth(),
                placeholder = { Text("Thông tin nhập") },
                shape = RoundedCornerShape(12.dp)
            )
            Spacer(modifier = Modifier.height(24.dp))
            Text(
                "Tự động cập nhật dữ liệu theo textfield: ${if (text.isEmpty()) "..." else text}",
                color = Color.Red,
                fontStyle = FontStyle.Italic,
                fontSize = 12.sp,
                textAlign = TextAlign.Center,
                modifier = Modifier.fillMaxWidth()
            )
        }
    }
}

// --- Layout Screens ---
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ColumnLayoutScreen(navController: NavController) {
    Scaffold(
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Column Layout", color = Color(0xFF2196F3), fontWeight = FontWeight.Bold) },
                navigationIcon = {
                    IconButton(onClick = { navController.popBackStack() }) {
                        Icon(Icons.Default.KeyboardArrowLeft, contentDescription = "Back", tint = Color(0xFF2196F3))
                    }
                }
            )
        }
    ) { padding ->
        Column(modifier = Modifier.fillMaxSize().padding(padding).padding(32.dp), verticalArrangement = Arrangement.spacedBy(24.dp)) {
            Box(modifier = Modifier.fillMaxWidth().height(120.dp).background(Color(0xFFA5D6A7), RoundedCornerShape(16.dp)))
            Box(modifier = Modifier.fillMaxWidth().height(120.dp).background(Color(0xFF4CAF50), RoundedCornerShape(16.dp)))
            Box(modifier = Modifier.fillMaxWidth().height(120.dp).background(Color(0xFF81C784), RoundedCornerShape(16.dp)))
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RowLayoutScreen(navController: NavController) {
    Scaffold(
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Row Layout", color = Color(0xFF2196F3), fontWeight = FontWeight.Bold) },
                navigationIcon = {
                    IconButton(onClick = { navController.popBackStack() }) {
                        Icon(Icons.Default.KeyboardArrowLeft, contentDescription = "Back", tint = Color(0xFF2196F3))
                    }
                }
            )
        }
    ) { padding ->
        LazyColumn(modifier = Modifier.fillMaxSize().padding(padding).padding(32.dp), verticalArrangement = Arrangement.spacedBy(16.dp)) {
            items(4) {
                Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(16.dp)) {
                    Box(modifier = Modifier.weight(1f).aspectRatio(1f).background(Color(0xFFBBDEFB), RoundedCornerShape(8.dp)))
                    Box(modifier = Modifier.weight(1f).aspectRatio(1f).background(Color(0xFF2196F3), RoundedCornerShape(8.dp)))
                    Box(modifier = Modifier.weight(1f).aspectRatio(1f).background(Color(0xFF90CAF9), RoundedCornerShape(8.dp)))
                }
            }
        }
    }
}
