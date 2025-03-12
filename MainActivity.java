package com.example.p7;

import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {
    private static final int REQUEST_CODE_IMAGE = 1;

    private static final String DEFAULT_TITLE = "new";

    private ImageView imageView;
    private TextView imagePlaceholder;
    private TextView titleTextView;
    private TextView counterTextView;
    private ArrayList<CounterItem> counterList = new ArrayList<>();
    private int counter = 0;
    private SharedPreferences preferences;
    private Uri imageUri;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 뷰 초기화
        imageView = findViewById(R.id.imageView);
        imagePlaceholder = findViewById(R.id.imagePlaceholder);
        titleTextView = findViewById(R.id.titleTextView);
        counterTextView = findViewById(R.id.counterTextView);
        Button incrementButton = findViewById(R.id.incrementButton);
        Button decrementButton = findViewById(R.id.decrementButton);
        Button resetButton = findViewById(R.id.resetButton);
        Button editTitleButton = findViewById(R.id.editTitleButton);
        Button deleteButton = findViewById(R.id.deleteButton);
        Button menuButton = findViewById(R.id.menuButton);

        preferences = getSharedPreferences("CounterApp", MODE_PRIVATE);

        // 데이터 복원
        restoreCounterList();
        restoreData();

        // 이미지 선택
        imageView.setOnClickListener(v -> openImagePicker());
        imagePlaceholder.setOnClickListener(v -> openImagePicker());

        // 증가 버튼
        incrementButton.setOnClickListener(v -> {
            counter++;
            updateCounter();
        });

        // 감소 버튼
        decrementButton.setOnClickListener(v -> {
            counter--;
            updateCounter();
        });

        // 리셋 버튼
        resetButton.setOnClickListener(v -> {
            counter = 0;
            updateCounter();
        });

        // 제목 수정 버튼
        editTitleButton.setOnClickListener(v -> editTitle());

        // 삭제 버튼
        deleteButton.setOnClickListener(v -> deleteCounter());

        // 메뉴 버튼
        menuButton.setOnClickListener(v -> showMenuOptions());
    }

    @Override
    protected void onPause() {
        super.onPause();
        saveData(); // 앱이 백그라운드로 전환되기 전에 저장
    }


    private void openImagePicker() {
        Intent intent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
        startActivityForResult(intent, REQUEST_CODE_IMAGE);
    }
/*
    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_CODE_IMAGE && resultCode == RESULT_OK && data != null) {
            imageUri = data.getData();
            imageView.setImageURI(imageUri);
            imagePlaceholder.setVisibility(View.GONE);

            // 이미지 경로 저장 및 counterList 업데이트
            updateImageUriInPreferencesAndList();
        }
    }
 */
@Override
protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if (requestCode == REQUEST_CODE_IMAGE && resultCode == RESULT_OK && data != null) {
        imageUri = data.getData();
        if (imageUri != null) {
            getContentResolver().takePersistableUriPermission(
                    imageUri, Intent.FLAG_GRANT_READ_URI_PERMISSION);
            imageView.setImageURI(imageUri);
            imagePlaceholder.setVisibility(View.GONE);
            updateImageUriInPreferencesAndList();
        } else {
            Toast.makeText(this, "이미지를 선택하지 않았습니다.", Toast.LENGTH_SHORT).show();
        }
    }
}


    private void updateImageUriInPreferencesAndList() {
        if (imageUri != null) {
            // 이미지 경로를 SharedPreferences에 저장
            preferences.edit().putString("imagePath", imageUri.toString()).apply();

            // counterList에서 현재 선택된 항목의 이미지 URI 업데이트
            String currentTitle = titleTextView.getText().toString();
            for (CounterItem item : counterList) {
                if (item.getTitle().equals(currentTitle)) {
                    item.setImageUri(imageUri.toString());
                    break;
                }
            }

            // counterList 저장
            saveCounterList();
        }
    }


    // 클래스 멤버 변수 선언
    private int previousColor = -1;

    private void updateCounter() {
        // 카운터 값 텍스트 업데이트
        counterTextView.setText(String.valueOf(counter));

        // 색상 변경
        int color = getNextColor(counter);
        counterTextView.setTextColor(color);

        // 현재 선택된 제목 저장
        preferences.edit().putString("lastSelectedTitle", titleTextView.getText().toString()).apply();

        // counterList 업데이트 및 저장
        String currentTitle = titleTextView.getText().toString();
        boolean itemFound = false;

        for (CounterItem item : counterList) {
            if (item.getTitle().equals(currentTitle)) {
                item.setCount(counter);

                // 이미지 URI 업데이트 시 null 체크
                if (imageUri != null) {
                    item.setImageUri(imageUri.toString());
                }
                itemFound = true;
                break;
            }
        }


        if (!itemFound && !currentTitle.equals("제목")) {
            CounterItem newItem = new CounterItem(currentTitle, counter, imageUri != null ? imageUri.toString() : null);
            counterList.add(newItem);
        }

        saveCounterList();
    }

    // 색상 결정 메서드
    private int getNextColor(int counter) {
        int color;

        if (counter <= 9) {
            // 0~9는 흰색
            color = ContextCompat.getColor(this, android.R.color.white);
        } else {
            // 10 이상부터는 10 단위로 고정된 색상 적용
            int[] colors = {
                    ContextCompat.getColor(this, android.R.color.holo_purple),
                    ContextCompat.getColor(this, android.R.color.holo_blue_light),
                    ContextCompat.getColor(this, android.R.color.holo_red_light),
                    ContextCompat.getColor(this, android.R.color.holo_green_light),
                    ContextCompat.getColor(this, android.R.color.holo_orange_light),
            };

            // 10 단위별 색상 결정
            int rangeIndex = (counter - 10) / 10; // 10~19 => 0, 20~29 => 1 ...
            int colorIndex = rangeIndex % colors.length; // 색상 배열의 범위를 초과하지 않도록 모듈로 연산
            color = colors[colorIndex];

            // 이전 색상 업데이트 (필요 시 사용)
            previousColor = color;
        }

        return color;
    }





    private void editTitle() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("제목 및 카운트 수정");

        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.VERTICAL);
        layout.setPadding(50, 20, 50, 20);

        final EditText titleInput = new EditText(this);
        titleInput.setHint("제목 입력");
        titleInput.setText(titleTextView.getText().toString());
        layout.addView(titleInput);

        final EditText counterInput = new EditText(this);
        counterInput.setHint("카운트 값 입력");
        counterInput.setInputType(android.text.InputType.TYPE_CLASS_NUMBER);
        counterInput.setText(String.valueOf(counter));
        layout.addView(counterInput);

        builder.setView(layout);

        builder.setPositiveButton("확인", (dialog, which) -> {
            String newTitle = titleInput.getText().toString().trim();
            String newCounterValue = counterInput.getText().toString().trim();

            if (!newTitle.isEmpty() && !newCounterValue.isEmpty()) {
                try {
                    int newCount = Integer.parseInt(newCounterValue);
                    String oldTitle = titleTextView.getText().toString();

                    // Update counterList
                    for (CounterItem item : counterList) {
                        if (item.getTitle().equals(oldTitle)) {
                            item.setTitle(newTitle);
                            item.setCount(newCount);
                            item.setImageUri(imageUri != null ? imageUri.toString() : null);
                            break;
                        }
                    }
                    saveCounterList();

                    titleTextView.setText(newTitle);
                    counter = newCount;
                    updateCounter();

                    Toast.makeText(this, "수정되었습니다.", Toast.LENGTH_SHORT).show();
                } catch (NumberFormatException e) {
                    Toast.makeText(this, "유효한 숫자를 입력하세요.", Toast.LENGTH_SHORT).show();
                }
            } else {
                Toast.makeText(this, "제목과 카운트값을 입력하세요.", Toast.LENGTH_SHORT).show();
            }
        });

        builder.setNegativeButton("취소", null);
        builder.show();
    }


    private void deleteCounter() {
        String currentTitle = titleTextView.getText().toString();

        // 기본 계수가 마지막 하나로 남아있으면 삭제할 수 없도록 처리
        if (counterList.size() == 1 && counterList.get(0).getTitle().equals(DEFAULT_TITLE)) {
            Toast.makeText(this, "기본 계수는 삭제할 수 없습니다.", Toast.LENGTH_SHORT).show();
            return;
        }



        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("카운트 삭제");
        builder.setMessage("정말로 '" + currentTitle + "' 계수를 삭제하시겠습니까?");
        builder.setPositiveButton("삭제", (dialog, which) -> {
            counterList.removeIf(item -> item.getTitle().equals(currentTitle));
            saveCounterList();

            // 삭제 후, 마지막 계수가 없으면 기본 계수 추가
            if (counterList.isEmpty()) {
                CounterItem defaultItem = new CounterItem(DEFAULT_TITLE, 0, null);
                counterList.add(defaultItem);
                saveCounterList();
                loadCounterData(defaultItem);
                Toast.makeText(this, "마지막 계수가 삭제되어 기본 계수가 생성되었습니다.", Toast.LENGTH_SHORT).show();
            } else {
                // 삭제 후 첫 번째 계수 로드
                loadCounterData(counterList.get(0));
            }

            Toast.makeText(this, "'" + currentTitle + "' 계수가 삭제되었습니다.", Toast.LENGTH_SHORT).show();
        });
        builder.setNegativeButton("취소", null);
        builder.show();
    }


    private void saveData() {
        preferences.edit().putString("title", titleTextView.getText().toString()).apply();
        preferences.edit().putInt("counter", counter).apply();
        if (imageUri != null) {
            preferences.edit().putString("imagePath", imageUri.toString()).apply();
        }

        // counterList를 JSON 형식으로 저장
        Gson gson = new Gson();
        String json = gson.toJson(counterList);
        preferences.edit().putString("counterList", json).apply();
    }


    private void restoreData() {
        restoreCounterList();

        String savedTitle = preferences.getString("lastSelectedTitle", DEFAULT_TITLE);
        titleTextView.setText(savedTitle);

        for (CounterItem item : counterList) {
            if (item.getTitle().equals(savedTitle)) {
                counter = item.getCount();
                imageUri = item.getImageUri() != null ? Uri.parse(item.getImageUri()) : null;
                break;
            }
        }

        if (imageUri != null) {
            try {
                imageView.setImageURI(imageUri);
                imagePlaceholder.setVisibility(View.GONE);
            } catch (Exception e) {
                Log.e("restoreData", "이미지 로드 실패: " + e.getMessage());
                imageView.setImageURI(null);
                imagePlaceholder.setVisibility(View.VISIBLE);
            }
        } else {
            imageView.setImageURI(null);
            imagePlaceholder.setVisibility(View.VISIBLE);
        }

        updateCounter();
    }



/*
    private void restoreCounterList() {
        Gson gson = new Gson();
        String json = preferences.getString("counterList", null);
        Type type = new TypeToken<ArrayList<CounterItem>>() {}.getType();

        // counterList가 null일 경우에만 기본 계수를 추가
        if (json != null) {
            counterList = gson.fromJson(json, type);
        } else {
            counterList = new ArrayList<>();
        }

        // "기본 계수 추가 여부" 확인
        boolean isFirstRun = preferences.getBoolean("isFirstRun", true);

        // 처음 실행일 때만 기본 계수를 추가
        if (isFirstRun) {
            // 기본 계수 항목 추가
            counterList.add(new CounterItem(DEFAULT_TITLE, 0, null));
            saveCounterList();

            // "첫 실행 여부"를 false로 업데이트
            preferences.edit().putBoolean("isFirstRun", false).apply();
        }

        // 마지막 저장된 제목과 동기화
        String savedTitle = preferences.getString("lastSelectedTitle", DEFAULT_TITLE);
        counter = 0;
        imageUri = null;

        for (CounterItem item : counterList) {
            if (item.getTitle().equals(savedTitle)) {
                counter = item.getCount();
                imageUri = item.getImageUri() != null ? Uri.parse(item.getImageUri()) : null;
                break;
            }
        }
    }
*/

    private void restoreCounterList() {
        Gson gson = new Gson();
        String json = preferences.getString("counterList", null);
        Type type = new TypeToken<ArrayList<CounterItem>>() {}.getType();

        if (json != null) {
            try {
                counterList = gson.fromJson(json, type);
            } catch (Exception e) {
                Log.e("restoreCounterList", "데이터 복원 실패: " + e.getMessage());
                counterList = new ArrayList<>();
            }
        } else {
            counterList = new ArrayList<>();
        }

        if (counterList.isEmpty()) {
            counterList.add(new CounterItem(DEFAULT_TITLE, 0, null));
            saveCounterList();
        }
    }




    private void showMenuOptions() {
        // 메뉴 항목 표시 및 처리
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("메뉴");

        // 메뉴 항목 목록 정의
        builder.setItems(new CharSequence[]{"계수 추가", "계수 목록"}, (dialog, which) -> {
            if (which == 0) {
                // '계수 추가' 선택 시
                addNewCounter();
            } else if (which == 1) {
                // '계수 목록' 선택 시
                showCounterList();
            }
        });

        builder.show();
    }

    private void saveCounterList() {
        // counterList를 Gson을 사용하여 JSON 형식으로 변환
        Gson gson = new Gson();
        String json = gson.toJson(counterList);

        // SharedPreferences에 JSON 문자열 저장
        preferences.edit().putString("counterList", json).apply();
    }

    private void addNewCounter() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("새 계수 추가");

        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.VERTICAL);
        layout.setPadding(50, 20, 50, 20);

        final EditText titleInput = new EditText(this);
        titleInput.setHint("제목 입력");
        layout.addView(titleInput);

        final EditText counterInput = new EditText(this);
        counterInput.setHint("카운트 값 입력");
        counterInput.setInputType(android.text.InputType.TYPE_CLASS_NUMBER);
        layout.addView(counterInput);

        builder.setView(layout);

        builder.setPositiveButton("확인", (dialog, which) -> {
            String newTitle = titleInput.getText().toString().trim();
            String newCounterValue = counterInput.getText().toString().trim();

            if (counterList.stream().anyMatch(item -> item.getTitle().equals(newTitle))) {
                Toast.makeText(this, "이미 존재하는 제목입니다.", Toast.LENGTH_SHORT).show();
                return;
            }

            if (!newTitle.isEmpty() && !newCounterValue.isEmpty()) {
                try {
                    int newCount = Integer.parseInt(newCounterValue);
                    counterList.add(new CounterItem(newTitle, newCount, null));
                    saveCounterList();

                    titleTextView.setText(newTitle);
                    counter = newCount;
                    imageUri = null;
                    // 이미지 뷰 초기화
                    imageView.setImageURI(null);
                    imagePlaceholder.setVisibility(View.VISIBLE);

                    updateCounter();
                    Toast.makeText(this, "새 계수가 추가되었습니다.", Toast.LENGTH_SHORT).show();
                } catch (NumberFormatException e) {
                    Toast.makeText(this, "유효한 숫자를 입력하세요.", Toast.LENGTH_SHORT).show();
                }
            } else {
                Toast.makeText(this, "제목과 카운트값을 입력하세요.", Toast.LENGTH_SHORT).show();
            }
        });

        builder.setNegativeButton("취소", null);
        builder.show();
    }


    private void showCounterList() {
        if (counterList.isEmpty()) {
            Toast.makeText(this, "저장된 계수가 없습니다.", Toast.LENGTH_SHORT).show();
            return;
        }

        // 제목과 값을 포함한 문자열 배열 생성
        String[] counterDetails = new String[counterList.size()];
        for (int i = 0; i < counterList.size(); i++) {
            CounterItem item = counterList.get(i);
            counterDetails[i] = item.getTitle() + "  값: " + item.getCount(); // 제목과 값 표시
        }

        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("계수 목록");
        builder.setItems(counterDetails, (dialog, which) -> {
            CounterItem selectedItem = counterList.get(which);
            loadCounterData(selectedItem);
        });

        builder.setPositiveButton("확인", null);
        builder.show();
    }

    private void loadCounterData(CounterItem item) {
        titleTextView.setText(item.getTitle());
        counter = item.getCount();
        imageUri = item.getImageUri() != null ? Uri.parse(item.getImageUri()) : null;

        if (imageUri != null) {
            try {
                imageUri = Uri.parse(item.getImageUri());
                imageView.setImageURI(imageUri);
                imagePlaceholder.setVisibility(View.GONE);
            } catch (Exception e) {
                Log.e("loadCounterData", "이미지 로딩 오류", e);
                imageView.setImageURI(null);
                imagePlaceholder.setVisibility(View.VISIBLE);
            }
        } else {
            imageUri = null;
            imageView.setImageURI(null);
            imagePlaceholder.setVisibility(View.VISIBLE);
        }

        updateCounter();
    }

}