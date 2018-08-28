from .decorators import plusfriend_wrap


@plusfriend_wrap
def on_init(request):
    return {'type': 'text'}


@plusfriend_wrap
def on_message(request):
    message_type = request.JSON['type']        # text, photo, audio(m4a), video(mp4)
    content = request.JSON['content']  # photo 타입일 경우에는 이미지 URL

    response = 'ECHO) [{}] {}'.format(message_type, content)

    return {
        'message': {
            'text': response,
        }
    }


@plusfriend_wrap
def on_added(request):
    pass


@plusfriend_wrap
def on_block(request, user_key):
    pass


@plusfriend_wrap
def on_leave(request, user_key):
    pass

