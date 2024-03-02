class ApiResponse{
    constructor(statusCode, data, message="Response sent") {
        this.statusCode = statusCode,
        this.data = data,
        this.message = message
    }
}

export {
    ApiResponse,
}