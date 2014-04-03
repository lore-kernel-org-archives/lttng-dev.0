From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: [PATCH lttng-modules] Add V4L2 instrumentation
Date: Thu, 3 Apr 2014 10:50:40 +0200
Message-ID: <CAEiAFz2KCRVu22KYm_sGf+omu7QOwng-0ppDM6Cr8WA_bDsdnQ__25014.8109080785$1396516625$gmane$org@mail.gmail.com>
References: <5335D6D8.3060005@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0598734824=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1WVdME-0006sD-1u
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 04:50:48 -0400
Received: by mail-qg0-f52.google.com with SMTP id q107so1418327qgd.25
 for <lttng-dev@lists.lttng.org>; Thu, 03 Apr 2014 01:50:40 -0700 (PDT)
In-Reply-To: <5335D6D8.3060005@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Wade Farnsworth <wade_farnsworth@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0598734824==
Content-Type: multipart/alternative; boundary=001a1134a766ea23d104f61f7ede

--001a1134a766ea23d104f61f7ede
Content-Type: text/plain; charset=ISO-8859-1

Hi Wade,
I've tried this (very useful) new tracepoints, but I get the following
compile warning:

  CC [M]  /home/jang/src/git-trees/lttng-modules/probes/lttng-kprobes.o
In file included from
/home/jang/src/git-trees/lttng-modules/probes/../instrumentation/events/lttng-module/../../../probes/define_trace.h:141:0,
                 from
/home/jang/src/git-trees/lttng-modules/probes/../instrumentation/events/lttng-module/v4l2.h:157,
                 from
/home/jang/src/git-trees/lttng-modules/probes/lttng-probe-v4l2.c:40:
/home/jang/src/git-trees/lttng-modules/probes/../instrumentation/events/lttng-module/../../../probes/../instrumentation/events/lttng-module/v4l2.h:69:0:
warning: "V4L2_TRACE_EVENT" redefined [enabled by default]
include/trace/events/v4l2.h:69:0: note: this is the location of the
previous definition

Which makes sense to me because TRACE_HEADER_MULTI_READ is probably true
and then we have the kernel and LTTng both define
V4L2_TRACE_EVENT. Renaming the LTTng variant to LTTNG_V4L2_TRACE_EVENT
solved the problem for me.
Should I post a patch or do you want to solve it otherwise?

Regards, Jan


2014-03-28 21:08 GMT+01:00 Wade Farnsworth <wade_farnsworth@mentor.com>:

> Add instrumentation for the V4L2 tracepoints that first appeared in
> Linux v3.14 (commit 2d01237389dc64b37745ce87e64d6808b6eed582 in Linus's
> tree).
>
> Signed-off-by: Wade Farnsworth <wade_farnsworth@mentor.com>
> ---
>  instrumentation/events/lttng-module/v4l2.h | 157
> +++++++++++++++++++++++++++++
>  instrumentation/events/mainline/v4l2.h     | 157
> +++++++++++++++++++++++++++++
>  probes/Makefile                            |   6 ++
>  probes/lttng-probe-v4l2.c                  |  44 ++++++++
>  4 files changed, 364 insertions(+)
>  create mode 100644 instrumentation/events/lttng-module/v4l2.h
>  create mode 100644 instrumentation/events/mainline/v4l2.h
>  create mode 100644 probes/lttng-probe-v4l2.c
>
> diff --git a/instrumentation/events/lttng-module/v4l2.h
> b/instrumentation/events/lttng-module/v4l2.h
> new file mode 100644
> index 0000000..c2d1161
> --- /dev/null
> +++ b/instrumentation/events/lttng-module/v4l2.h
> @@ -0,0 +1,157 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM v4l2
> +
> +#if !defined(_TRACE_V4L2_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_V4L2_H
> +
> +#include <linux/tracepoint.h>
> +
> +#define show_type(type)
>             \
> +       __print_symbolic(type,
>     \
> +               { V4L2_BUF_TYPE_VIDEO_CAPTURE,        "VIDEO_CAPTURE" },
>     \
> +               { V4L2_BUF_TYPE_VIDEO_OUTPUT,         "VIDEO_OUTPUT" },
>      \
> +               { V4L2_BUF_TYPE_VIDEO_OVERLAY,        "VIDEO_OVERLAY" },
>     \
> +               { V4L2_BUF_TYPE_VBI_CAPTURE,          "VBI_CAPTURE" },
>     \
> +               { V4L2_BUF_TYPE_VBI_OUTPUT,           "VBI_OUTPUT" },
>      \
> +               { V4L2_BUF_TYPE_SLICED_VBI_CAPTURE,   "SLICED_VBI_CAPTURE"
> },  \
> +               { V4L2_BUF_TYPE_SLICED_VBI_OUTPUT,    "SLICED_VBI_OUTPUT"
> },   \
> +               { V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY,
> "VIDEO_OUTPUT_OVERLAY" },\
> +               { V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> "VIDEO_CAPTURE_MPLANE" },\
> +               { V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>  "VIDEO_OUTPUT_MPLANE" }, \
> +               { V4L2_BUF_TYPE_PRIVATE,              "PRIVATE" })
> +
> +#define show_field(field)                                              \
> +       __print_symbolic(field,                                         \
> +               { V4L2_FIELD_ANY,               "ANY" },                \
> +               { V4L2_FIELD_NONE,              "NONE" },               \
> +               { V4L2_FIELD_TOP,               "TOP" },                \
> +               { V4L2_FIELD_BOTTOM,            "BOTTOM" },             \
> +               { V4L2_FIELD_INTERLACED,        "INTERLACED" },         \
> +               { V4L2_FIELD_SEQ_TB,            "SEQ_TB" },             \
> +               { V4L2_FIELD_SEQ_BT,            "SEQ_BT" },             \
> +               { V4L2_FIELD_ALTERNATE,         "ALTERNATE" },          \
> +               { V4L2_FIELD_INTERLACED_TB,     "INTERLACED_TB" },      \
> +               { V4L2_FIELD_INTERLACED_BT,     "INTERLACED_BT" })
> +
> +#define show_timecode_type(type)                                       \
> +       __print_symbolic(type,                                          \
> +               { V4L2_TC_TYPE_24FPS,           "24FPS" },              \
> +               { V4L2_TC_TYPE_25FPS,           "25FPS" },              \
> +               { V4L2_TC_TYPE_30FPS,           "30FPS" },              \
> +               { V4L2_TC_TYPE_50FPS,           "50FPS" },              \
> +               { V4L2_TC_TYPE_60FPS,           "60FPS" })
> +
> +#define show_flags(flags)
>    \
> +       __print_flags(flags, "|",
>     \
> +               { V4L2_BUF_FLAG_MAPPED,              "MAPPED" },
>    \
> +               { V4L2_BUF_FLAG_QUEUED,              "QUEUED" },
>    \
> +               { V4L2_BUF_FLAG_DONE,                "DONE" },
>    \
> +               { V4L2_BUF_FLAG_KEYFRAME,            "KEYFRAME" },
>    \
> +               { V4L2_BUF_FLAG_PFRAME,              "PFRAME" },
>    \
> +               { V4L2_BUF_FLAG_BFRAME,              "BFRAME" },
>    \
> +               { V4L2_BUF_FLAG_ERROR,               "ERROR" },
>     \
> +               { V4L2_BUF_FLAG_TIMECODE,            "TIMECODE" },
>    \
> +               { V4L2_BUF_FLAG_PREPARED,            "PREPARED" },
>    \
> +               { V4L2_BUF_FLAG_NO_CACHE_INVALIDATE, "NO_CACHE_INVALIDATE"
> }, \
> +               { V4L2_BUF_FLAG_NO_CACHE_CLEAN,      "NO_CACHE_CLEAN" },
>    \
> +               { V4L2_BUF_FLAG_TIMESTAMP_MASK,      "TIMESTAMP_MASK" },
>    \
> +               { V4L2_BUF_FLAG_TIMESTAMP_UNKNOWN,   "TIMESTAMP_UNKNOWN"
> },   \
> +               { V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC, "TIMESTAMP_MONOTONIC"
> }, \
> +               { V4L2_BUF_FLAG_TIMESTAMP_COPY,      "TIMESTAMP_COPY" })
> +
> +#define show_timecode_flags(flags)                                       \
> +       __print_flags(flags, "|",                                         \
> +               { V4L2_TC_FLAG_DROPFRAME,       "DROPFRAME" },            \
> +               { V4L2_TC_FLAG_COLORFRAME,      "COLORFRAME" },           \
> +               { V4L2_TC_USERBITS_USERDEFINED, "USERBITS_USERDEFINED" }, \
> +               { V4L2_TC_USERBITS_8BITCHARS,   "USERBITS_8BITCHARS" })
> +
> +#define V4L2_TRACE_EVENT(event_name)                                   \
> +       TRACE_EVENT(event_name,                                         \
> +               TP_PROTO(int minor, struct v4l2_buffer *buf),           \
> +                                                                       \
> +               TP_ARGS(minor, buf),                                    \
> +                                                                       \
> +               TP_STRUCT__entry(                                       \
> +                       __field(int, minor)                             \
> +                       __field(u32, index)                             \
> +                       __field(u32, type)                              \
> +                       __field(u32, bytesused)                         \
> +                       __field(u32, flags)                             \
> +                       __field(u32, field)                             \
> +                       __field(s64, timestamp)                         \
> +                       __field(u32, timecode_type)                     \
> +                       __field(u32, timecode_flags)                    \
> +                       __field(u8, timecode_frames)                    \
> +                       __field(u8, timecode_seconds)                   \
> +                       __field(u8, timecode_minutes)                   \
> +                       __field(u8, timecode_hours)                     \
> +                       __field(u8, timecode_userbits0)                 \
> +                       __field(u8, timecode_userbits1)                 \
> +                       __field(u8, timecode_userbits2)                 \
> +                       __field(u8, timecode_userbits3)                 \
> +                       __field(u32, sequence)                          \
> +               ),                                                      \
> +                                                                       \
> +               TP_fast_assign(                                         \
> +                       tp_assign(minor, minor);                        \
> +                       tp_assign(index, buf->index);                   \
> +                       tp_assign(type, buf->type);                     \
> +                       tp_assign(bytesused, buf->bytesused);           \
> +                       tp_assign(flags, buf->flags);                   \
> +                       tp_assign(field, buf->field);                   \
> +                       tp_assign(timestamp,                            \
> +                               timeval_to_ns(&buf->timestamp));        \
> +                       tp_assign(timecode_type, buf->timecode.type);   \
> +                       tp_assign(timecode_flags, buf->timecode.flags); \
> +                       tp_assign(timecode_frames,                      \
> +                               buf->timecode.frames);                  \
> +                       tp_assign(timecode_seconds,                     \
> +                               buf->timecode.seconds);                 \
> +                       tp_assign(timecode_minutes,                     \
> +                               buf->timecode.minutes);                 \
> +                       tp_assign(timecode_hours, buf->timecode.hours); \
> +                       tp_assign(timecode_userbits0,                   \
> +                               buf->timecode.userbits[0]);             \
> +                       tp_assign(timecode_userbits1,                   \
> +                               buf->timecode.userbits[1]);             \
> +                       tp_assign(timecode_userbits2,                   \
> +                               buf->timecode.userbits[2]);             \
> +                       tp_assign(timecode_userbits3,                   \
> +                               buf->timecode.userbits[3]);             \
> +                       tp_assign(sequence, buf->sequence);             \
> +               ),                                                      \
> +                                                                       \
> +               TP_printk("minor = %d, index = %u, type = %s, "         \
> +                         "bytesused = %u, flags = %s, "                \
> +                         "field = %s, timestamp = %llu, timecode = { " \
> +                         "type = %s, flags = %s, frames = %u, "        \
> +                         "seconds = %u, minutes = %u, hours = %u, "    \
> +                         "userbits = { %u %u %u %u } }, "              \
> +                         "sequence = %u", __entry->minor,              \
> +                         __entry->index, show_type(__entry->type),     \
> +                         __entry->bytesused,                           \
> +                         show_flags(__entry->flags),                   \
> +                         show_field(__entry->field),                   \
> +                         __entry->timestamp,                           \
> +                         show_timecode_type(__entry->timecode_type),   \
> +                         show_timecode_flags(__entry->timecode_flags), \
> +                         __entry->timecode_frames,                     \
> +                         __entry->timecode_seconds,                    \
> +                         __entry->timecode_minutes,                    \
> +                         __entry->timecode_hours,                      \
> +                         __entry->timecode_userbits0,                  \
> +                         __entry->timecode_userbits1,                  \
> +                         __entry->timecode_userbits2,                  \
> +                         __entry->timecode_userbits3,                  \
> +                         __entry->sequence                             \
> +               )                                                       \
> +       )
> +
> +V4L2_TRACE_EVENT(v4l2_dqbuf)
> +V4L2_TRACE_EVENT(v4l2_qbuf)
> +
> +#endif /* if !defined(_TRACE_V4L2_H) || defined(TRACE_HEADER_MULTI_READ)
> */
> +
> +/* This part must be outside protection */
> +#include "../../../probes/define_trace.h"
> diff --git a/instrumentation/events/mainline/v4l2.h
> b/instrumentation/events/mainline/v4l2.h
> new file mode 100644
> index 0000000..ef94eca
> --- /dev/null
> +++ b/instrumentation/events/mainline/v4l2.h
> @@ -0,0 +1,157 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM v4l2
> +
> +#if !defined(_TRACE_V4L2_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_V4L2_H
> +
> +#include <linux/tracepoint.h>
> +
> +#define show_type(type)
>             \
> +       __print_symbolic(type,
>     \
> +               { V4L2_BUF_TYPE_VIDEO_CAPTURE,        "VIDEO_CAPTURE" },
>     \
> +               { V4L2_BUF_TYPE_VIDEO_OUTPUT,         "VIDEO_OUTPUT" },
>      \
> +               { V4L2_BUF_TYPE_VIDEO_OVERLAY,        "VIDEO_OVERLAY" },
>     \
> +               { V4L2_BUF_TYPE_VBI_CAPTURE,          "VBI_CAPTURE" },
>     \
> +               { V4L2_BUF_TYPE_VBI_OUTPUT,           "VBI_OUTPUT" },
>      \
> +               { V4L2_BUF_TYPE_SLICED_VBI_CAPTURE,   "SLICED_VBI_CAPTURE"
> },  \
> +               { V4L2_BUF_TYPE_SLICED_VBI_OUTPUT,    "SLICED_VBI_OUTPUT"
> },   \
> +               { V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY,
> "VIDEO_OUTPUT_OVERLAY" },\
> +               { V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> "VIDEO_CAPTURE_MPLANE" },\
> +               { V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>  "VIDEO_OUTPUT_MPLANE" }, \
> +               { V4L2_BUF_TYPE_PRIVATE,              "PRIVATE" })
> +
> +#define show_field(field)                                              \
> +       __print_symbolic(field,                                         \
> +               { V4L2_FIELD_ANY,               "ANY" },                \
> +               { V4L2_FIELD_NONE,              "NONE" },               \
> +               { V4L2_FIELD_TOP,               "TOP" },                \
> +               { V4L2_FIELD_BOTTOM,            "BOTTOM" },             \
> +               { V4L2_FIELD_INTERLACED,        "INTERLACED" },         \
> +               { V4L2_FIELD_SEQ_TB,            "SEQ_TB" },             \
> +               { V4L2_FIELD_SEQ_BT,            "SEQ_BT" },             \
> +               { V4L2_FIELD_ALTERNATE,         "ALTERNATE" },          \
> +               { V4L2_FIELD_INTERLACED_TB,     "INTERLACED_TB" },      \
> +               { V4L2_FIELD_INTERLACED_BT,     "INTERLACED_BT" })
> +
> +#define show_timecode_type(type)                                       \
> +       __print_symbolic(type,                                          \
> +               { V4L2_TC_TYPE_24FPS,           "24FPS" },              \
> +               { V4L2_TC_TYPE_25FPS,           "25FPS" },              \
> +               { V4L2_TC_TYPE_30FPS,           "30FPS" },              \
> +               { V4L2_TC_TYPE_50FPS,           "50FPS" },              \
> +               { V4L2_TC_TYPE_60FPS,           "60FPS" })
> +
> +#define show_flags(flags)
>    \
> +       __print_flags(flags, "|",
>     \
> +               { V4L2_BUF_FLAG_MAPPED,              "MAPPED" },
>    \
> +               { V4L2_BUF_FLAG_QUEUED,              "QUEUED" },
>    \
> +               { V4L2_BUF_FLAG_DONE,                "DONE" },
>    \
> +               { V4L2_BUF_FLAG_KEYFRAME,            "KEYFRAME" },
>    \
> +               { V4L2_BUF_FLAG_PFRAME,              "PFRAME" },
>    \
> +               { V4L2_BUF_FLAG_BFRAME,              "BFRAME" },
>    \
> +               { V4L2_BUF_FLAG_ERROR,               "ERROR" },
>     \
> +               { V4L2_BUF_FLAG_TIMECODE,            "TIMECODE" },
>    \
> +               { V4L2_BUF_FLAG_PREPARED,            "PREPARED" },
>    \
> +               { V4L2_BUF_FLAG_NO_CACHE_INVALIDATE, "NO_CACHE_INVALIDATE"
> }, \
> +               { V4L2_BUF_FLAG_NO_CACHE_CLEAN,      "NO_CACHE_CLEAN" },
>    \
> +               { V4L2_BUF_FLAG_TIMESTAMP_MASK,      "TIMESTAMP_MASK" },
>    \
> +               { V4L2_BUF_FLAG_TIMESTAMP_UNKNOWN,   "TIMESTAMP_UNKNOWN"
> },   \
> +               { V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC, "TIMESTAMP_MONOTONIC"
> }, \
> +               { V4L2_BUF_FLAG_TIMESTAMP_COPY,      "TIMESTAMP_COPY" })
> +
> +#define show_timecode_flags(flags)                                       \
> +       __print_flags(flags, "|",                                         \
> +               { V4L2_TC_FLAG_DROPFRAME,       "DROPFRAME" },            \
> +               { V4L2_TC_FLAG_COLORFRAME,      "COLORFRAME" },           \
> +               { V4L2_TC_USERBITS_USERDEFINED, "USERBITS_USERDEFINED" }, \
> +               { V4L2_TC_USERBITS_8BITCHARS,   "USERBITS_8BITCHARS" })
> +
> +#define V4L2_TRACE_EVENT(event_name)                                   \
> +       TRACE_EVENT(event_name,                                         \
> +               TP_PROTO(int minor, struct v4l2_buffer *buf),           \
> +                                                                       \
> +               TP_ARGS(minor, buf),                                    \
> +                                                                       \
> +               TP_STRUCT__entry(                                       \
> +                       __field(int, minor)                             \
> +                       __field(u32, index)                             \
> +                       __field(u32, type)                              \
> +                       __field(u32, bytesused)                         \
> +                       __field(u32, flags)                             \
> +                       __field(u32, field)                             \
> +                       __field(s64, timestamp)                         \
> +                       __field(u32, timecode_type)                     \
> +                       __field(u32, timecode_flags)                    \
> +                       __field(u8, timecode_frames)                    \
> +                       __field(u8, timecode_seconds)                   \
> +                       __field(u8, timecode_minutes)                   \
> +                       __field(u8, timecode_hours)                     \
> +                       __field(u8, timecode_userbits0)                 \
> +                       __field(u8, timecode_userbits1)                 \
> +                       __field(u8, timecode_userbits2)                 \
> +                       __field(u8, timecode_userbits3)                 \
> +                       __field(u32, sequence)                          \
> +               ),                                                      \
> +                                                                       \
> +               TP_fast_assign(                                         \
> +                       __entry->minor = minor;                         \
> +                       __entry->index = buf->index;                    \
> +                       __entry->type = buf->type;                      \
> +                       __entry->bytesused = buf->bytesused;            \
> +                       __entry->flags = buf->flags;                    \
> +                       __entry->field = buf->field;                    \
> +                       __entry->timestamp =                            \
> +                               timeval_to_ns(&buf->timestamp);         \
> +                       __entry->timecode_type = buf->timecode.type;    \
> +                       __entry->timecode_flags = buf->timecode.flags;  \
> +                       __entry->timecode_frames =                      \
> +                               buf->timecode.frames;                   \
> +                       __entry->timecode_seconds =                     \
> +                               buf->timecode.seconds;                  \
> +                       __entry->timecode_minutes =                     \
> +                               buf->timecode.minutes;                  \
> +                       __entry->timecode_hours = buf->timecode.hours;  \
> +                       __entry->timecode_userbits0 =                   \
> +                               buf->timecode.userbits[0];              \
> +                       __entry->timecode_userbits1 =                   \
> +                               buf->timecode.userbits[1];              \
> +                       __entry->timecode_userbits2 =                   \
> +                               buf->timecode.userbits[2];              \
> +                       __entry->timecode_userbits3 =                   \
> +                               buf->timecode.userbits[3];              \
> +                       __entry->sequence = buf->sequence;              \
> +               ),                                                      \
> +                                                                       \
> +               TP_printk("minor = %d, index = %u, type = %s, "         \
> +                         "bytesused = %u, flags = %s, "                \
> +                         "field = %s, timestamp = %llu, timecode = { " \
> +                         "type = %s, flags = %s, frames = %u, "        \
> +                         "seconds = %u, minutes = %u, hours = %u, "    \
> +                         "userbits = { %u %u %u %u } }, "              \
> +                         "sequence = %u", __entry->minor,              \
> +                         __entry->index, show_type(__entry->type),     \
> +                         __entry->bytesused,                           \
> +                         show_flags(__entry->flags),                   \
> +                         show_field(__entry->field),                   \
> +                         __entry->timestamp,                           \
> +                         show_timecode_type(__entry->timecode_type),   \
> +                         show_timecode_flags(__entry->timecode_flags), \
> +                         __entry->timecode_frames,                     \
> +                         __entry->timecode_seconds,                    \
> +                         __entry->timecode_minutes,                    \
> +                         __entry->timecode_hours,                      \
> +                         __entry->timecode_userbits0,                  \
> +                         __entry->timecode_userbits1,                  \
> +                         __entry->timecode_userbits2,                  \
> +                         __entry->timecode_userbits3,                  \
> +                         __entry->sequence                             \
> +               )                                                       \
> +       )
> +
> +V4L2_TRACE_EVENT(v4l2_dqbuf);
> +V4L2_TRACE_EVENT(v4l2_qbuf);
> +
> +#endif /* if !defined(_TRACE_V4L2_H) || defined(TRACE_HEADER_MULTI_READ)
> */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/probes/Makefile b/probes/Makefile
> index 63ca7ba..f98f2c5 100644
> --- a/probes/Makefile
> +++ b/probes/Makefile
> @@ -197,6 +197,12 @@ obj-m +=  $(shell \
>                 echo "lttng-probe-sunrpc.o" ; fi;)
>  endif
>
> +ifneq ($(CONFIG_VIDEO_V4L2),)
> +obj-m += $(shell \
> +       if [ $(VERSION) -ge 3 -a $(PATCHLEVEL) -ge 14 ] ; then \
> +               echo "lttng-probe-v4l2.o" ; fi;)
> +endif
> +
>  obj-m += lttng-probe-workqueue.o
>
>  ifneq ($(CONFIG_KALLSYMS_ALL),)
> diff --git a/probes/lttng-probe-v4l2.c b/probes/lttng-probe-v4l2.c
> new file mode 100644
> index 0000000..709ccb2
> --- /dev/null
> +++ b/probes/lttng-probe-v4l2.c
> @@ -0,0 +1,44 @@
> +/*
> + * probes/lttng-probe-v4l2.c
> + *
> + * LTTng v4l2 probes.
> + *
> + * Copyright (C) 2010-2012 Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com>
> + * Copyright (C) 2012,2013 Mentor Graphics Corp.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; only
> + * version 2.1 of the License.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA
> + */
> +
> +#include <linux/module.h>
> +#include <linux/videodev2.h>
> +
> +/*
> + * Create the tracepoint static inlines from the kernel to validate that
> our
> + * trace event macros match the kernel we run on.
> + */
> +#include <trace/events/v4l2.h>
> +
> +/*
> + * Create LTTng tracepoint probes.
> + */
> +#define LTTNG_PACKAGE_BUILD
> +#define CREATE_TRACE_POINTS
> +#define TRACE_INCLUDE_PATH ../instrumentation/events/lttng-module
> +
> +#include "../instrumentation/events/lttng-module/v4l2.h"
> +
> +MODULE_LICENSE("GPL and additional rights");
> +MODULE_AUTHOR("Wade Farnsworth <wade_farnsworth@mentor.com>");
> +MODULE_DESCRIPTION("LTTng v4l2 probes");
> --
> 1.9.0
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--001a1134a766ea23d104f61f7ede
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi Wade,<br></div>I&#39;ve tried this =
(very useful) new tracepoints, but I get the following compile warning:<br>=
<br>=A0 CC [M]=A0 /home/jang/src/git-trees/lttng-modules/probes/lttng-kprob=
es.o<br>
In file included from /home/jang/src/git-trees/lttng-modules/probes/../inst=
rumentation/events/lttng-module/../../../probes/define_trace.h:141:0,<br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from /home/jang/src/git-tr=
ees/lttng-modules/probes/../instrumentation/events/lttng-module/v4l2.h:157,=
<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from /home/jang/src/git-tr=
ees/lttng-modules/probes/lttng-probe-v4l2.c:40:<br>/home/jang/src/git-trees=
/lttng-modules/probes/../instrumentation/events/lttng-module/../../../probe=
s/../instrumentation/events/lttng-module/v4l2.h:69:0: warning: &quot;V4L2_T=
RACE_EVENT&quot; redefined [enabled by default]<br>
include/trace/events/v4l2.h:69:0: note: this is the location of the previou=
s definition<br><br></div>Which makes sense to me because TRACE_HEADER_MULT=
I_READ is probably true and then we have the kernel and LTTng both define<b=
r>
V4L2_TRACE_EVENT. Renaming the LTTng variant to LTTNG_V4L2_TRACE_EVENT solv=
ed the problem for me.<br></div>Should I post a patch or do you want to sol=
ve it otherwise?<br><br></div>Regards, Jan<br></div><div class=3D"gmail_ext=
ra">
<br><br><div class=3D"gmail_quote">2014-03-28 21:08 GMT+01:00 Wade Farnswor=
th <span dir=3D"ltr">&lt;<a href=3D"mailto:wade_farnsworth@mentor.com" targ=
et=3D"_blank">wade_farnsworth@mentor.com</a>&gt;</span>:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
Add instrumentation for the V4L2 tracepoints that first appeared in<br>
Linux v3.14 (commit 2d01237389dc64b37745ce87e64d6808b6eed582 in Linus&#39;s=
<br>
tree).<br>
<br>
Signed-off-by: Wade Farnsworth &lt;<a href=3D"mailto:wade_farnsworth@mentor=
.com">wade_farnsworth@mentor.com</a>&gt;<br>
---<br>
=A0instrumentation/events/lttng-module/v4l2.h | 157 +++++++++++++++++++++++=
++++++<br>
=A0instrumentation/events/mainline/v4l2.h =A0 =A0 | 157 +++++++++++++++++++=
++++++++++<br>
=A0probes/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 6 ++<br>
=A0probes/lttng-probe-v4l2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A044 +++=
+++++<br>
=A04 files changed, 364 insertions(+)<br>
=A0create mode 100644 instrumentation/events/lttng-module/v4l2.h<br>
=A0create mode 100644 instrumentation/events/mainline/v4l2.h<br>
=A0create mode 100644 probes/lttng-probe-v4l2.c<br>
<br>
diff --git a/instrumentation/events/lttng-module/v4l2.h b/instrumentation/e=
vents/lttng-module/v4l2.h<br>
new file mode 100644<br>
index 0000000..c2d1161<br>
--- /dev/null<br>
+++ b/instrumentation/events/lttng-module/v4l2.h<br>
@@ -0,0 +1,157 @@<br>
+#undef TRACE_SYSTEM<br>
+#define TRACE_SYSTEM v4l2<br>
+<br>
+#if !defined(_TRACE_V4L2_H) || defined(TRACE_HEADER_MULTI_READ)<br>
+#define _TRACE_V4L2_H<br>
+<br>
+#include &lt;linux/tracepoint.h&gt;<br>
+<br>
+#define show_type(type) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 \<br>
+ =A0 =A0 =A0 __print_symbolic(type, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VIDEO_CAPTURE, =A0 =A0 =A0 =
=A0&quot;VIDEO_CAPTURE&quot; }, =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VIDEO_OUTPUT, =A0 =A0 =A0 =A0=
 &quot;VIDEO_OUTPUT&quot; }, =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VIDEO_OVERLAY, =A0 =A0 =A0 =
=A0&quot;VIDEO_OVERLAY&quot; }, =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VBI_CAPTURE, =A0 =A0 =A0 =A0 =
=A0&quot;VBI_CAPTURE&quot; }, =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VBI_OUTPUT, =A0 =A0 =A0 =A0 =
=A0 &quot;VBI_OUTPUT&quot; }, =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_SLICED_VBI_CAPTURE, =A0 &quot=
;SLICED_VBI_CAPTURE&quot; }, =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_SLICED_VBI_OUTPUT, =A0 =A0&qu=
ot;SLICED_VBI_OUTPUT&quot; }, =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY, &quot;V=
IDEO_OUTPUT_OVERLAY&quot; },\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE, &quot;V=
IDEO_CAPTURE_MPLANE&quot; },\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE, =A0&quot=
;VIDEO_OUTPUT_MPLANE&quot; }, \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_PRIVATE, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&quot;PRIVATE&quot; })<br>
+<br>
+#define show_field(field) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 __print_symbolic(field, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_ANY, =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 &quot;ANY&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_NONE, =A0 =A0 =A0 =A0 =A0 =A0 =
=A0&quot;NONE&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_TOP, =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 &quot;TOP&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_BOTTOM, =A0 =A0 =A0 =A0 =A0 =A0&=
quot;BOTTOM&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_INTERLACED, =A0 =A0 =A0 =A0&quot=
;INTERLACED&quot; }, =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_SEQ_TB, =A0 =A0 =A0 =A0 =A0 =A0&=
quot;SEQ_TB&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_SEQ_BT, =A0 =A0 =A0 =A0 =A0 =A0&=
quot;SEQ_BT&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_ALTERNATE, =A0 =A0 =A0 =A0 &quot=
;ALTERNATE&quot; }, =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_INTERLACED_TB, =A0 =A0 &quot;INT=
ERLACED_TB&quot; }, =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_INTERLACED_BT, =A0 =A0 &quot;INT=
ERLACED_BT&quot; })<br>
+<br>
+#define show_timecode_type(type) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 __print_symbolic(type, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_TYPE_24FPS, =A0 =A0 =A0 =A0 =A0 &qu=
ot;24FPS&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_TYPE_25FPS, =A0 =A0 =A0 =A0 =A0 &qu=
ot;25FPS&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_TYPE_30FPS, =A0 =A0 =A0 =A0 =A0 &qu=
ot;30FPS&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_TYPE_50FPS, =A0 =A0 =A0 =A0 =A0 &qu=
ot;50FPS&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_TYPE_60FPS, =A0 =A0 =A0 =A0 =A0 &qu=
ot;60FPS&quot; })<br>
+<br>
+#define show_flags(flags) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 __print_flags(flags, &quot;|&quot;, =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_MAPPED, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&quot;MAPPED&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_QUEUED, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&quot;QUEUED&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_DONE, =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0&quot;DONE&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_KEYFRAME, =A0 =A0 =A0 =A0 =A0=
 =A0&quot;KEYFRAME&quot; }, =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_PFRAME, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&quot;PFRAME&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_BFRAME, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&quot;BFRAME&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_ERROR, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 &quot;ERROR&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_TIMECODE, =A0 =A0 =A0 =A0 =A0=
 =A0&quot;TIMECODE&quot; }, =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_PREPARED, =A0 =A0 =A0 =A0 =A0=
 =A0&quot;PREPARED&quot; }, =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_NO_CACHE_INVALIDATE, &quot;NO=
_CACHE_INVALIDATE&quot; }, \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_NO_CACHE_CLEAN, =A0 =A0 =A0&q=
uot;NO_CACHE_CLEAN&quot; }, =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_TIMESTAMP_MASK, =A0 =A0 =A0&q=
uot;TIMESTAMP_MASK&quot; }, =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_TIMESTAMP_UNKNOWN, =A0 &quot;=
TIMESTAMP_UNKNOWN&quot; }, =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC, &quot;TI=
MESTAMP_MONOTONIC&quot; }, \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_TIMESTAMP_COPY, =A0 =A0 =A0&q=
uot;TIMESTAMP_COPY&quot; })<br>
+<br>
+#define show_timecode_flags(flags) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 __print_flags(flags, &quot;|&quot;, =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_FLAG_DROPFRAME, =A0 =A0 =A0 &quot;D=
ROPFRAME&quot; }, =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_FLAG_COLORFRAME, =A0 =A0 =A0&quot;C=
OLORFRAME&quot; }, =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_USERBITS_USERDEFINED, &quot;USERBIT=
S_USERDEFINED&quot; }, \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_USERBITS_8BITCHARS, =A0 &quot;USERB=
ITS_8BITCHARS&quot; })<br>
+<br>
+#define V4L2_TRACE_EVENT(event_name) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 TRACE_EVENT(event_name, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 TP_PROTO(int minor, struct v4l2_buffer *buf),=
 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 TP_ARGS(minor, buf), =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 TP_STRUCT__entry( =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(int, minor) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, index) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, type) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, bytesused) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, flags) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, field) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(s64, timestamp) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, timecode_type) =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, timecode_flags) =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_frames) =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_seconds)=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_minutes)=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_hours) =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_userbits=
0) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_userbits=
1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_userbits=
2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_userbits=
3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, sequence) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ), =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 TP_fast_assign( =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(minor, minor); =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(index, buf-&gt;inde=
x); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(type, buf-&gt;type)=
; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(bytesused, buf-&gt;=
bytesused); =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(flags, buf-&gt;flag=
s); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(field, buf-&gt;fiel=
d); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(timestamp, =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeval_to_ns=
(&amp;buf-&gt;timestamp)); =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(timecode_type, buf-=
&gt;timecode.type); =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(timecode_flags, buf=
-&gt;timecode.flags); \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(timecode_frames, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf-&gt;timec=
ode.frames); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(timecode_seconds, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf-&gt;timec=
ode.seconds); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(timecode_minutes, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf-&gt;timec=
ode.minutes); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(timecode_hours, buf=
-&gt;timecode.hours); \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(timecode_userbits0,=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf-&gt;timec=
ode.userbits[0]); =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(timecode_userbits1,=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf-&gt;timec=
ode.userbits[1]); =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(timecode_userbits2,=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf-&gt;timec=
ode.userbits[2]); =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(timecode_userbits3,=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf-&gt;timec=
ode.userbits[3]); =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tp_assign(sequence, buf-&gt;s=
equence); =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ), =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 TP_printk(&quot;minor =3D %d, index =3D %u, t=
ype =3D %s, &quot; =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;bytesused =3D %u, f=
lags =3D %s, &quot; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;field =3D %s, times=
tamp =3D %llu, timecode =3D { &quot; \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;type =3D %s, flags =
=3D %s, frames =3D %u, &quot; =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;seconds =3D %u, min=
utes =3D %u, hours =3D %u, &quot; =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;userbits =3D { %u %=
u %u %u } }, &quot; =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;sequence =3D %u&quo=
t;, __entry-&gt;minor, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;index, show_t=
ype(__entry-&gt;type), =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;bytesused, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_flags(__entry-&gt;fl=
ags), =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_field(__entry-&gt;fi=
eld), =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timestamp, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_timecode_type(__entr=
y-&gt;timecode_type), =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_timecode_flags(__ent=
ry-&gt;timecode_flags), \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_fram=
es, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_seco=
nds, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_minu=
tes, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_hour=
s, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_user=
bits0, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_user=
bits1, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_user=
bits2, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_user=
bits3, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;sequence =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 )<br>
+<br>
+V4L2_TRACE_EVENT(v4l2_dqbuf)<br>
+V4L2_TRACE_EVENT(v4l2_qbuf)<br>
+<br>
+#endif /* if !defined(_TRACE_V4L2_H) || defined(TRACE_HEADER_MULTI_READ) *=
/<br>
+<br>
+/* This part must be outside protection */<br>
+#include &quot;../../../probes/define_trace.h&quot;<br>
diff --git a/instrumentation/events/mainline/v4l2.h b/instrumentation/event=
s/mainline/v4l2.h<br>
new file mode 100644<br>
index 0000000..ef94eca<br>
--- /dev/null<br>
+++ b/instrumentation/events/mainline/v4l2.h<br>
@@ -0,0 +1,157 @@<br>
+#undef TRACE_SYSTEM<br>
+#define TRACE_SYSTEM v4l2<br>
+<br>
+#if !defined(_TRACE_V4L2_H) || defined(TRACE_HEADER_MULTI_READ)<br>
+#define _TRACE_V4L2_H<br>
+<br>
+#include &lt;linux/tracepoint.h&gt;<br>
+<br>
+#define show_type(type) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 \<br>
+ =A0 =A0 =A0 __print_symbolic(type, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VIDEO_CAPTURE, =A0 =A0 =A0 =
=A0&quot;VIDEO_CAPTURE&quot; }, =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VIDEO_OUTPUT, =A0 =A0 =A0 =A0=
 &quot;VIDEO_OUTPUT&quot; }, =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VIDEO_OVERLAY, =A0 =A0 =A0 =
=A0&quot;VIDEO_OVERLAY&quot; }, =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VBI_CAPTURE, =A0 =A0 =A0 =A0 =
=A0&quot;VBI_CAPTURE&quot; }, =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VBI_OUTPUT, =A0 =A0 =A0 =A0 =
=A0 &quot;VBI_OUTPUT&quot; }, =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_SLICED_VBI_CAPTURE, =A0 &quot=
;SLICED_VBI_CAPTURE&quot; }, =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_SLICED_VBI_OUTPUT, =A0 =A0&qu=
ot;SLICED_VBI_OUTPUT&quot; }, =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY, &quot;V=
IDEO_OUTPUT_OVERLAY&quot; },\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE, &quot;V=
IDEO_CAPTURE_MPLANE&quot; },\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE, =A0&quot=
;VIDEO_OUTPUT_MPLANE&quot; }, \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_TYPE_PRIVATE, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&quot;PRIVATE&quot; })<br>
+<br>
+#define show_field(field) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 __print_symbolic(field, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_ANY, =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 &quot;ANY&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_NONE, =A0 =A0 =A0 =A0 =A0 =A0 =
=A0&quot;NONE&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_TOP, =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 &quot;TOP&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_BOTTOM, =A0 =A0 =A0 =A0 =A0 =A0&=
quot;BOTTOM&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_INTERLACED, =A0 =A0 =A0 =A0&quot=
;INTERLACED&quot; }, =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_SEQ_TB, =A0 =A0 =A0 =A0 =A0 =A0&=
quot;SEQ_TB&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_SEQ_BT, =A0 =A0 =A0 =A0 =A0 =A0&=
quot;SEQ_BT&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_ALTERNATE, =A0 =A0 =A0 =A0 &quot=
;ALTERNATE&quot; }, =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_INTERLACED_TB, =A0 =A0 &quot;INT=
ERLACED_TB&quot; }, =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_FIELD_INTERLACED_BT, =A0 =A0 &quot;INT=
ERLACED_BT&quot; })<br>
+<br>
+#define show_timecode_type(type) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 __print_symbolic(type, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_TYPE_24FPS, =A0 =A0 =A0 =A0 =A0 &qu=
ot;24FPS&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_TYPE_25FPS, =A0 =A0 =A0 =A0 =A0 &qu=
ot;25FPS&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_TYPE_30FPS, =A0 =A0 =A0 =A0 =A0 &qu=
ot;30FPS&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_TYPE_50FPS, =A0 =A0 =A0 =A0 =A0 &qu=
ot;50FPS&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_TYPE_60FPS, =A0 =A0 =A0 =A0 =A0 &qu=
ot;60FPS&quot; })<br>
+<br>
+#define show_flags(flags) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 __print_flags(flags, &quot;|&quot;, =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_MAPPED, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&quot;MAPPED&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_QUEUED, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&quot;QUEUED&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_DONE, =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0&quot;DONE&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_KEYFRAME, =A0 =A0 =A0 =A0 =A0=
 =A0&quot;KEYFRAME&quot; }, =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_PFRAME, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&quot;PFRAME&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_BFRAME, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&quot;BFRAME&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_ERROR, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 &quot;ERROR&quot; }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_TIMECODE, =A0 =A0 =A0 =A0 =A0=
 =A0&quot;TIMECODE&quot; }, =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_PREPARED, =A0 =A0 =A0 =A0 =A0=
 =A0&quot;PREPARED&quot; }, =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_NO_CACHE_INVALIDATE, &quot;NO=
_CACHE_INVALIDATE&quot; }, \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_NO_CACHE_CLEAN, =A0 =A0 =A0&q=
uot;NO_CACHE_CLEAN&quot; }, =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_TIMESTAMP_MASK, =A0 =A0 =A0&q=
uot;TIMESTAMP_MASK&quot; }, =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_TIMESTAMP_UNKNOWN, =A0 &quot;=
TIMESTAMP_UNKNOWN&quot; }, =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC, &quot;TI=
MESTAMP_MONOTONIC&quot; }, \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_BUF_FLAG_TIMESTAMP_COPY, =A0 =A0 =A0&q=
uot;TIMESTAMP_COPY&quot; })<br>
+<br>
+#define show_timecode_flags(flags) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 __print_flags(flags, &quot;|&quot;, =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_FLAG_DROPFRAME, =A0 =A0 =A0 &quot;D=
ROPFRAME&quot; }, =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_FLAG_COLORFRAME, =A0 =A0 =A0&quot;C=
OLORFRAME&quot; }, =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_USERBITS_USERDEFINED, &quot;USERBIT=
S_USERDEFINED&quot; }, \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { V4L2_TC_USERBITS_8BITCHARS, =A0 &quot;USERB=
ITS_8BITCHARS&quot; })<br>
+<br>
+#define V4L2_TRACE_EVENT(event_name) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 TRACE_EVENT(event_name, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 TP_PROTO(int minor, struct v4l2_buffer *buf),=
 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 TP_ARGS(minor, buf), =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 TP_STRUCT__entry( =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(int, minor) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, index) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, type) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, bytesused) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, flags) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, field) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(s64, timestamp) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, timecode_type) =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, timecode_flags) =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_frames) =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_seconds)=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_minutes)=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_hours) =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_userbits=
0) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_userbits=
1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_userbits=
2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u8, timecode_userbits=
3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __field(u32, sequence) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ), =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 TP_fast_assign( =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;minor =3D minor; =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;index =3D buf-&gt=
;index; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;type =3D buf-&gt;=
type; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;bytesused =3D buf=
-&gt;bytesused; =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;flags =3D buf-&gt=
;flags; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;field =3D buf-&gt=
;field; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timestamp =3D =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeval_to_ns=
(&amp;buf-&gt;timestamp); =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_type =3D=
 buf-&gt;timecode.type; =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_flags =
=3D buf-&gt;timecode.flags; =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_frames =
=3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf-&gt;timec=
ode.frames; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_seconds =
=3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf-&gt;timec=
ode.seconds; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_minutes =
=3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf-&gt;timec=
ode.minutes; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_hours =
=3D buf-&gt;timecode.hours; =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_userbits=
0 =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf-&gt;timec=
ode.userbits[0]; =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_userbits=
1 =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf-&gt;timec=
ode.userbits[1]; =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_userbits=
2 =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf-&gt;timec=
ode.userbits[2]; =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_userbits=
3 =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf-&gt;timec=
ode.userbits[3]; =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;sequence =3D buf-=
&gt;sequence; =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ), =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 TP_printk(&quot;minor =3D %d, index =3D %u, t=
ype =3D %s, &quot; =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;bytesused =3D %u, f=
lags =3D %s, &quot; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;field =3D %s, times=
tamp =3D %llu, timecode =3D { &quot; \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;type =3D %s, flags =
=3D %s, frames =3D %u, &quot; =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;seconds =3D %u, min=
utes =3D %u, hours =3D %u, &quot; =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;userbits =3D { %u %=
u %u %u } }, &quot; =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;sequence =3D %u&quo=
t;, __entry-&gt;minor, =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;index, show_t=
ype(__entry-&gt;type), =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;bytesused, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_flags(__entry-&gt;fl=
ags), =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_field(__entry-&gt;fi=
eld), =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timestamp, =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_timecode_type(__entr=
y-&gt;timecode_type), =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_timecode_flags(__ent=
ry-&gt;timecode_flags), \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_fram=
es, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_seco=
nds, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_minu=
tes, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_hour=
s, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_user=
bits0, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_user=
bits1, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_user=
bits2, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;timecode_user=
bits3, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __entry-&gt;sequence =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 )<br>
+<br>
+V4L2_TRACE_EVENT(v4l2_dqbuf);<br>
+V4L2_TRACE_EVENT(v4l2_qbuf);<br>
+<br>
+#endif /* if !defined(_TRACE_V4L2_H) || defined(TRACE_HEADER_MULTI_READ) *=
/<br>
+<br>
+/* This part must be outside protection */<br>
+#include &lt;trace/define_trace.h&gt;<br>
diff --git a/probes/Makefile b/probes/Makefile<br>
index 63ca7ba..f98f2c5 100644<br>
--- a/probes/Makefile<br>
+++ b/probes/Makefile<br>
@@ -197,6 +197,12 @@ obj-m +=3D =A0$(shell \<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo &quot;lttng-probe-sunrpc.o&quot; ; fi;=
)<br>
=A0endif<br>
<br>
+ifneq ($(CONFIG_VIDEO_V4L2),)<br>
+obj-m +=3D $(shell \<br>
+ =A0 =A0 =A0 if [ $(VERSION) -ge 3 -a $(PATCHLEVEL) -ge 14 ] ; then \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo &quot;lttng-probe-v4l2.o&quot; ; fi;)<br=
>
+endif<br>
+<br>
=A0obj-m +=3D lttng-probe-workqueue.o<br>
<br>
=A0ifneq ($(CONFIG_KALLSYMS_ALL),)<br>
diff --git a/probes/lttng-probe-v4l2.c b/probes/lttng-probe-v4l2.c<br>
new file mode 100644<br>
index 0000000..709ccb2<br>
--- /dev/null<br>
+++ b/probes/lttng-probe-v4l2.c<br>
@@ -0,0 +1,44 @@<br>
+/*<br>
+ * probes/lttng-probe-v4l2.c<br>
+ *<br>
+ * LTTng v4l2 probes.<br>
+ *<br>
+ * Copyright (C) 2010-2012 Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu=
.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>
+ * Copyright (C) 2012,2013 Mentor Graphics Corp.<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; only<br>
+ * version 2.1 of the License.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU<br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, write to the Free Software<br>
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-130=
1 USA<br>
+ */<br>
+<br>
+#include &lt;linux/module.h&gt;<br>
+#include &lt;linux/videodev2.h&gt;<br>
+<br>
+/*<br>
+ * Create the tracepoint static inlines from the kernel to validate that o=
ur<br>
+ * trace event macros match the kernel we run on.<br>
+ */<br>
+#include &lt;trace/events/v4l2.h&gt;<br>
+<br>
+/*<br>
+ * Create LTTng tracepoint probes.<br>
+ */<br>
+#define LTTNG_PACKAGE_BUILD<br>
+#define CREATE_TRACE_POINTS<br>
+#define TRACE_INCLUDE_PATH ../instrumentation/events/lttng-module<br>
+<br>
+#include &quot;../instrumentation/events/lttng-module/v4l2.h&quot;<br>
+<br>
+MODULE_LICENSE(&quot;GPL and additional rights&quot;);<br>
+MODULE_AUTHOR(&quot;Wade Farnsworth &lt;<a href=3D"mailto:wade_farnsworth@=
mentor.com">wade_farnsworth@mentor.com</a>&gt;&quot;);<br>
+MODULE_DESCRIPTION(&quot;LTTng v4l2 probes&quot;);<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.0<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</font></span></blockquote></div><br></div>

--001a1134a766ea23d104f61f7ede--


--===============0598734824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0598734824==--
