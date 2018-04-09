package com.github.tunagami.kground

import com.amazonaws.services.lambda.runtime.Context
import com.amazonaws.services.lambda.runtime.RequestHandler

class Handler: RequestHandler<Map<String, Any>, Handler.Response> {

    override fun handleRequest(input: Map<String, Any>, context: Context?): Response {
        val logger = context?.logger ?: throw IllegalArgumentException()
        logger.log("input map: $input")
        return Response(location = "https://w000t!.com")
    }

    data class Response(val location: String)
}