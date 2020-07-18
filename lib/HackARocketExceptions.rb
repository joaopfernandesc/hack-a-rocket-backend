module HackARocketExceptions
    class HackARocketException < StandardError; end
    class BadParameters < HackARocketException; end
    class GenericError < HackARocketException; end
    class NotFound < HackARocketException; end
    class UnauthorizedOperation < HackARocketException; end
    class CreateConflict < HackARocketException; end
    class Forbidden < HackARocketException; end
  end