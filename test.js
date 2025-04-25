const allMovies = [
    {
        id: 1,
        titulo: "Cidade de Deus",
        diretor: "Fernando Meirelles",
        genero: ["Drama", "Crime"]
    },
    {
        id: 2,
        titulo: "Jogos Mortais",
        diretor: "James Wan",
        genero: ["Terror", "Suspense"]
    }
];



const getAllTitles = (movies) => {
    return movies.map(movie => movie.titulo);
};

console.log(getAllTitles(allMovies));