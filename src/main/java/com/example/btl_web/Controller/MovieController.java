package com.example.btl_web.Controller;

import com.example.btl_web.Model.Movie;
import com.example.btl_web.Repository.MovieRepo;
import com.example.btl_web.Repository.ShowtimeRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin/movies")
@RequiredArgsConstructor
public class MovieController {

    private final MovieRepo movieRepo;
    private final ShowtimeRepo showtimeRepo;

    @GetMapping
    public String moviesPage(@RequestParam(required = false) String keyword,
            @RequestParam(required = false) String status,
            Model model) {
        List<Movie> movies;
        String normalizedStatus = normalizeStatus(status);
        String trimmedKeyword = keyword == null ? null : keyword.trim();

        boolean hasKeyword = trimmedKeyword != null && !trimmedKeyword.isEmpty();
        boolean hasStatus = normalizedStatus != null && !normalizedStatus.isEmpty();

        if (hasKeyword && hasStatus) {
            String loweredKeyword = trimmedKeyword == null ? "" : trimmedKeyword.toLowerCase();
            movies = movieRepo.findByStatus(normalizedStatus)
                    .stream()
                    .filter(movie -> movie.getTitle() != null
                    && movie.getTitle().toLowerCase().contains(loweredKeyword))
                    .collect(Collectors.toList());
        } else if (hasKeyword) {
            movies = movieRepo.findByTitleContainingIgnoreCase(trimmedKeyword);
        } else if (hasStatus) {
            movies = movieRepo.findByStatus(normalizedStatus);
        } else {
            movies = movieRepo.findAll();
        }

        model.addAttribute("movies", movies);
        model.addAttribute("keyword", keyword);
        model.addAttribute("status", normalizedStatus);

        return "movies_management";
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("movie", new Movie());
        model.addAttribute("isEdit", false);
        return "movie_form";
    }

    @PostMapping("/create")
    public String createMovie(@ModelAttribute Movie movie,
            RedirectAttributes redirectAttributes) {

        if (movie.getTitle() == null || movie.getTitle().trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Tên phim không được để trống!");
            return "redirect:/admin/movies/create";
        }

        if (movie.getDuration() == null || movie.getDuration() <= 0) {
            redirectAttributes.addFlashAttribute("error", "Thời lượng phim phải lớn hơn 0!");
            return "redirect:/admin/movies/create";
        }

        String normalizedStatus = normalizeStatus(movie.getStatus());
        if (normalizedStatus == null || normalizedStatus.isEmpty()) {
            normalizedStatus = "Đang chiếu";
        }
        movie.setStatus(normalizedStatus);

        movieRepo.save(movie);
        redirectAttributes.addFlashAttribute("message", "Thêm phim thành công!");
        return "redirect:/admin/movies?status=" + URLEncoder.encode(normalizedStatus, StandardCharsets.UTF_8);
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Integer id,
            Model model,
            RedirectAttributes redirectAttributes) {

        Optional<Movie> optionalMovie = movieRepo.findById(id);

        if (optionalMovie.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy phim!");
            return "redirect:/admin/movies";
        }

        model.addAttribute("movie", optionalMovie.get());
        model.addAttribute("isEdit", true);
        return "movie_form";
    }

    @PostMapping("/update")
    public String updateMovie(@ModelAttribute Movie movie,
            RedirectAttributes redirectAttributes) {

        if (movie.getMovieId() == null || !movieRepo.existsById(movie.getMovieId())) {
            redirectAttributes.addFlashAttribute("error", "Phim không tồn tại!");
            return "redirect:/admin/movies";
        }

        if (movie.getTitle() == null || movie.getTitle().trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Tên phim không được để trống!");
            return "redirect:/admin/movies/edit/" + movie.getMovieId();
        }

        if (movie.getDuration() == null || movie.getDuration() <= 0) {
            redirectAttributes.addFlashAttribute("error", "Thời lượng phim phải lớn hơn 0!");
            return "redirect:/admin/movies/edit/" + movie.getMovieId();
        }

        Movie existingMovie = movieRepo.findById(movie.getMovieId()).orElse(null);
        if (existingMovie == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy phim để cập nhật!");
            return "redirect:/admin/movies";
        }

        existingMovie.setTitle(movie.getTitle());
        existingMovie.setDescription(movie.getDescription());
        existingMovie.setDuration(movie.getDuration());
        existingMovie.setPoster(movie.getPoster());
        existingMovie.setTrailer(movie.getTrailer());
        existingMovie.setReleaseDate(movie.getReleaseDate());
        String normalizedStatus = normalizeStatus(movie.getStatus());
        if (normalizedStatus == null || normalizedStatus.isEmpty()) {
            normalizedStatus = "Đang chiếu";
        }
        existingMovie.setStatus(normalizedStatus);

        movieRepo.save(existingMovie);
        redirectAttributes.addFlashAttribute("message", "Cập nhật phim thành công!");
        return "redirect:/admin/movies?status=" + URLEncoder.encode(normalizedStatus, StandardCharsets.UTF_8);
    }

    @GetMapping("/delete/{id}")
    public String deleteMovie(@PathVariable Integer id,
            RedirectAttributes redirectAttributes) {

        if (!movieRepo.existsById(id)) {
            redirectAttributes.addFlashAttribute("error", "Phim không tồn tại!");
            return "redirect:/admin/movies";
        }

        if (!showtimeRepo.findByMovie_MovieId(id).isEmpty()) {
            redirectAttributes.addFlashAttribute("error",
                    "Phim này đang có suất chiếu, không thể xóa!");
            return "redirect:/admin/movies";
        }

        movieRepo.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa phim thành công!");
        return "redirect:/admin/movies";
    }

    private String normalizeStatus(String status) {
        if (status == null) {
            return null;
        }

        String normalized = status.trim();
        if (normalized.isEmpty()) {
            return null;
        }

        if ("ACTIVE".equalsIgnoreCase(normalized) || "Đang chiếu".equalsIgnoreCase(normalized)) {
            return "Đang chiếu";
        }

        if ("INACTIVE".equalsIgnoreCase(normalized) || "Sắp chiếu".equalsIgnoreCase(normalized)) {
            return "Sắp chiếu";
        }

        return normalized;
    }
}
