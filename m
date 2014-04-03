From: Wade Farnsworth <wade_farnsworth@mentor.com>
Subject: Re: [PATCH lttng-modules] Add V4L2 instrumentation
Date: Thu, 3 Apr 2014 07:49:59 -0700
Message-ID: <533D7517.2060401__26390.0548955009$1396536726$gmane$org@mentor.com>
References: <5335D6D8.3060005@mentor.com>
 <CAEiAFz2KCRVu22KYm_sGf+omu7QOwng-0ppDM6Cr8WA_bDsdnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wade_farnsworth@mentor.com>) id 1WViyd-0000xw-G1
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 10:50:57 -0400
In-Reply-To: <CAEiAFz2KCRVu22KYm_sGf+omu7QOwng-0ppDM6Cr8WA_bDsdnQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jan Glauber <jan.glauber@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Jan,

Thanks for catching this.  Since my patches have not been committed yet,
I'm inclined to include this fix in version 2, which I'll be sending
within the next few hours.

Regards,

Wade

Jan Glauber wrote:
> Hi Wade,
> I've tried this (very useful) new tracepoints, but I get the following
> compile warning:
> 
>   CC [M]  /home/jang/src/git-trees/lttng-modules/probes/lttng-kprobes.o
> In file included from
> /home/jang/src/git-trees/lttng-modules/probes/../instrumentation/events/lttng-module/../../../probes/define_trace.h:141:0,
>                  from
> /home/jang/src/git-trees/lttng-modules/probes/../instrumentation/events/lttng-module/v4l2.h:157,
>                  from
> /home/jang/src/git-trees/lttng-modules/probes/lttng-probe-v4l2.c:40:
> /home/jang/src/git-trees/lttng-modules/probes/../instrumentation/events/lttng-module/../../../probes/../instrumentation/events/lttng-module/v4l2.h:69:0:
> warning: "V4L2_TRACE_EVENT" redefined [enabled by default]
> include/trace/events/v4l2.h:69:0: note: this is the location of the
> previous definition
> 
> Which makes sense to me because TRACE_HEADER_MULTI_READ is probably true
> and then we have the kernel and LTTng both define
> V4L2_TRACE_EVENT. Renaming the LTTng variant to LTTNG_V4L2_TRACE_EVENT
> solved the problem for me.
> Should I post a patch or do you want to solve it otherwise?
> 
> Regards, Jan
> 
> 
> 2014-03-28 21:08 GMT+01:00 Wade Farnsworth <wade_farnsworth@mentor.com
> <mailto:wade_farnsworth@mentor.com>>:
> 
>     Add instrumentation for the V4L2 tracepoints that first appeared in
>     Linux v3.14 (commit 2d01237389dc64b37745ce87e64d6808b6eed582 in Linus's
>     tree).
> 
>     Signed-off-by: Wade Farnsworth <wade_farnsworth@mentor.com
>     <mailto:wade_farnsworth@mentor.com>>
>     ---
>      instrumentation/events/lttng-module/v4l2.h | 157
>     +++++++++++++++++++++++++++++
>      instrumentation/events/mainline/v4l2.h     | 157
>     +++++++++++++++++++++++++++++
>      probes/Makefile                            |   6 ++
>      probes/lttng-probe-v4l2.c                  |  44 ++++++++
>      4 files changed, 364 insertions(+)
>      create mode 100644 instrumentation/events/lttng-module/v4l2.h
>      create mode 100644 instrumentation/events/mainline/v4l2.h
>      create mode 100644 probes/lttng-probe-v4l2.c
> 
>     diff --git a/instrumentation/events/lttng-module/v4l2.h
>     b/instrumentation/events/lttng-module/v4l2.h
>     new file mode 100644
>     index 0000000..c2d1161
>     --- /dev/null
>     +++ b/instrumentation/events/lttng-module/v4l2.h
>     @@ -0,0 +1,157 @@
>     +#undef TRACE_SYSTEM
>     +#define TRACE_SYSTEM v4l2
>     +
>     +#if !defined(_TRACE_V4L2_H) || defined(TRACE_HEADER_MULTI_READ)
>     +#define _TRACE_V4L2_H
>     +
>     +#include <linux/tracepoint.h>
>     +
>     +#define show_type(type)                                            
>                       \
>     +       __print_symbolic(type,                                      
>               \
>     +               { V4L2_BUF_TYPE_VIDEO_CAPTURE,      
>      "VIDEO_CAPTURE" },       \
>     +               { V4L2_BUF_TYPE_VIDEO_OUTPUT,         "VIDEO_OUTPUT"
>     },        \
>     +               { V4L2_BUF_TYPE_VIDEO_OVERLAY,      
>      "VIDEO_OVERLAY" },       \
>     +               { V4L2_BUF_TYPE_VBI_CAPTURE,          "VBI_CAPTURE"
>     },         \
>     +               { V4L2_BUF_TYPE_VBI_OUTPUT,           "VBI_OUTPUT"
>     },          \
>     +               { V4L2_BUF_TYPE_SLICED_VBI_CAPTURE,  
>     "SLICED_VBI_CAPTURE" },  \
>     +               { V4L2_BUF_TYPE_SLICED_VBI_OUTPUT,  
>      "SLICED_VBI_OUTPUT" },   \
>     +               { V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY,
>     "VIDEO_OUTPUT_OVERLAY" },\
>     +               { V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>     "VIDEO_CAPTURE_MPLANE" },\
>     +               { V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>      "VIDEO_OUTPUT_MPLANE" }, \
>     +               { V4L2_BUF_TYPE_PRIVATE,              "PRIVATE" })
>     +
>     +#define show_field(field)                                          
>        \
>     +       __print_symbolic(field,                                    
>         \
>     +               { V4L2_FIELD_ANY,               "ANY" },            
>        \
>     +               { V4L2_FIELD_NONE,              "NONE" },          
>         \
>     +               { V4L2_FIELD_TOP,               "TOP" },            
>        \
>     +               { V4L2_FIELD_BOTTOM,            "BOTTOM" },        
>         \
>     +               { V4L2_FIELD_INTERLACED,        "INTERLACED" },    
>         \
>     +               { V4L2_FIELD_SEQ_TB,            "SEQ_TB" },        
>         \
>     +               { V4L2_FIELD_SEQ_BT,            "SEQ_BT" },        
>         \
>     +               { V4L2_FIELD_ALTERNATE,         "ALTERNATE" },      
>        \
>     +               { V4L2_FIELD_INTERLACED_TB,     "INTERLACED_TB" },  
>        \
>     +               { V4L2_FIELD_INTERLACED_BT,     "INTERLACED_BT" })
>     +
>     +#define show_timecode_type(type)                                  
>         \
>     +       __print_symbolic(type,                                      
>        \
>     +               { V4L2_TC_TYPE_24FPS,           "24FPS" },          
>        \
>     +               { V4L2_TC_TYPE_25FPS,           "25FPS" },          
>        \
>     +               { V4L2_TC_TYPE_30FPS,           "30FPS" },          
>        \
>     +               { V4L2_TC_TYPE_50FPS,           "50FPS" },          
>        \
>     +               { V4L2_TC_TYPE_60FPS,           "60FPS" })
>     +
>     +#define show_flags(flags)                                          
>              \
>     +       __print_flags(flags, "|",                                  
>               \
>     +               { V4L2_BUF_FLAG_MAPPED,              "MAPPED" },    
>              \
>     +               { V4L2_BUF_FLAG_QUEUED,              "QUEUED" },    
>              \
>     +               { V4L2_BUF_FLAG_DONE,                "DONE" },      
>              \
>     +               { V4L2_BUF_FLAG_KEYFRAME,            "KEYFRAME" },  
>              \
>     +               { V4L2_BUF_FLAG_PFRAME,              "PFRAME" },    
>              \
>     +               { V4L2_BUF_FLAG_BFRAME,              "BFRAME" },    
>              \
>     +               { V4L2_BUF_FLAG_ERROR,               "ERROR" },    
>               \
>     +               { V4L2_BUF_FLAG_TIMECODE,            "TIMECODE" },  
>              \
>     +               { V4L2_BUF_FLAG_PREPARED,            "PREPARED" },  
>              \
>     +               { V4L2_BUF_FLAG_NO_CACHE_INVALIDATE,
>     "NO_CACHE_INVALIDATE" }, \
>     +               { V4L2_BUF_FLAG_NO_CACHE_CLEAN,    
>      "NO_CACHE_CLEAN" },      \
>     +               { V4L2_BUF_FLAG_TIMESTAMP_MASK,    
>      "TIMESTAMP_MASK" },      \
>     +               { V4L2_BUF_FLAG_TIMESTAMP_UNKNOWN,  
>     "TIMESTAMP_UNKNOWN" },   \
>     +               { V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC,
>     "TIMESTAMP_MONOTONIC" }, \
>     +               { V4L2_BUF_FLAG_TIMESTAMP_COPY,      "TIMESTAMP_COPY" })
>     +
>     +#define show_timecode_flags(flags)                                
>           \
>     +       __print_flags(flags, "|",                                  
>           \
>     +               { V4L2_TC_FLAG_DROPFRAME,       "DROPFRAME" },      
>          \
>     +               { V4L2_TC_FLAG_COLORFRAME,      "COLORFRAME" },    
>           \
>     +               { V4L2_TC_USERBITS_USERDEFINED,
>     "USERBITS_USERDEFINED" }, \
>     +               { V4L2_TC_USERBITS_8BITCHARS,   "USERBITS_8BITCHARS" })
>     +
>     +#define V4L2_TRACE_EVENT(event_name)                              
>         \
>     +       TRACE_EVENT(event_name,                                    
>         \
>     +               TP_PROTO(int minor, struct v4l2_buffer *buf),      
>         \
>     +                                                                  
>         \
>     +               TP_ARGS(minor, buf),                                
>        \
>     +                                                                  
>         \
>     +               TP_STRUCT__entry(                                  
>         \
>     +                       __field(int, minor)                        
>         \
>     +                       __field(u32, index)                        
>         \
>     +                       __field(u32, type)                          
>        \
>     +                       __field(u32, bytesused)                    
>         \
>     +                       __field(u32, flags)                        
>         \
>     +                       __field(u32, field)                        
>         \
>     +                       __field(s64, timestamp)                    
>         \
>     +                       __field(u32, timecode_type)                
>         \
>     +                       __field(u32, timecode_flags)                
>        \
>     +                       __field(u8, timecode_frames)                
>        \
>     +                       __field(u8, timecode_seconds)              
>         \
>     +                       __field(u8, timecode_minutes)              
>         \
>     +                       __field(u8, timecode_hours)                
>         \
>     +                       __field(u8, timecode_userbits0)            
>         \
>     +                       __field(u8, timecode_userbits1)            
>         \
>     +                       __field(u8, timecode_userbits2)            
>         \
>     +                       __field(u8, timecode_userbits3)            
>         \
>     +                       __field(u32, sequence)                      
>        \
>     +               ),                                                  
>        \
>     +                                                                  
>         \
>     +               TP_fast_assign(                                    
>         \
>     +                       tp_assign(minor, minor);                    
>        \
>     +                       tp_assign(index, buf->index);              
>         \
>     +                       tp_assign(type, buf->type);                
>         \
>     +                       tp_assign(bytesused, buf->bytesused);      
>         \
>     +                       tp_assign(flags, buf->flags);              
>         \
>     +                       tp_assign(field, buf->field);              
>         \
>     +                       tp_assign(timestamp,                        
>        \
>     +                               timeval_to_ns(&buf->timestamp));    
>        \
>     +                       tp_assign(timecode_type,
>     buf->timecode.type);   \
>     +                       tp_assign(timecode_flags,
>     buf->timecode.flags); \
>     +                       tp_assign(timecode_frames,                  
>        \
>     +                               buf->timecode.frames);              
>        \
>     +                       tp_assign(timecode_seconds,                
>         \
>     +                               buf->timecode.seconds);            
>         \
>     +                       tp_assign(timecode_minutes,                
>         \
>     +                               buf->timecode.minutes);            
>         \
>     +                       tp_assign(timecode_hours,
>     buf->timecode.hours); \
>     +                       tp_assign(timecode_userbits0,              
>         \
>     +                               buf->timecode.userbits[0]);        
>         \
>     +                       tp_assign(timecode_userbits1,              
>         \
>     +                               buf->timecode.userbits[1]);        
>         \
>     +                       tp_assign(timecode_userbits2,              
>         \
>     +                               buf->timecode.userbits[2]);        
>         \
>     +                       tp_assign(timecode_userbits3,              
>         \
>     +                               buf->timecode.userbits[3]);        
>         \
>     +                       tp_assign(sequence, buf->sequence);        
>         \
>     +               ),                                                  
>        \
>     +                                                                  
>         \
>     +               TP_printk("minor = %d, index = %u, type = %s, "    
>         \
>     +                         "bytesused = %u, flags = %s, "            
>        \
>     +                         "field = %s, timestamp = %llu, timecode =
>     { " \
>     +                         "type = %s, flags = %s, frames = %u, "    
>        \
>     +                         "seconds = %u, minutes = %u, hours = %u, "
>        \
>     +                         "userbits = { %u %u %u %u } }, "          
>        \
>     +                         "sequence = %u", __entry->minor,          
>        \
>     +                         __entry->index, show_type(__entry->type),
>         \
>     +                         __entry->bytesused,                      
>         \
>     +                         show_flags(__entry->flags),              
>         \
>     +                         show_field(__entry->field),              
>         \
>     +                         __entry->timestamp,                      
>         \
>     +                        
>     show_timecode_type(__entry->timecode_type),   \
>     +                        
>     show_timecode_flags(__entry->timecode_flags), \
>     +                         __entry->timecode_frames,                
>         \
>     +                         __entry->timecode_seconds,                
>        \
>     +                         __entry->timecode_minutes,                
>        \
>     +                         __entry->timecode_hours,                  
>        \
>     +                         __entry->timecode_userbits0,              
>        \
>     +                         __entry->timecode_userbits1,              
>        \
>     +                         __entry->timecode_userbits2,              
>        \
>     +                         __entry->timecode_userbits3,              
>        \
>     +                         __entry->sequence                        
>         \
>     +               )                                                  
>         \
>     +       )
>     +
>     +V4L2_TRACE_EVENT(v4l2_dqbuf)
>     +V4L2_TRACE_EVENT(v4l2_qbuf)
>     +
>     +#endif /* if !defined(_TRACE_V4L2_H) ||
>     defined(TRACE_HEADER_MULTI_READ) */
>     +
>     +/* This part must be outside protection */
>     +#include "../../../probes/define_trace.h"
>     diff --git a/instrumentation/events/mainline/v4l2.h
>     b/instrumentation/events/mainline/v4l2.h
>     new file mode 100644
>     index 0000000..ef94eca
>     --- /dev/null
>     +++ b/instrumentation/events/mainline/v4l2.h
>     @@ -0,0 +1,157 @@
>     +#undef TRACE_SYSTEM
>     +#define TRACE_SYSTEM v4l2
>     +
>     +#if !defined(_TRACE_V4L2_H) || defined(TRACE_HEADER_MULTI_READ)
>     +#define _TRACE_V4L2_H
>     +
>     +#include <linux/tracepoint.h>
>     +
>     +#define show_type(type)                                            
>                       \
>     +       __print_symbolic(type,                                      
>               \
>     +               { V4L2_BUF_TYPE_VIDEO_CAPTURE,      
>      "VIDEO_CAPTURE" },       \
>     +               { V4L2_BUF_TYPE_VIDEO_OUTPUT,         "VIDEO_OUTPUT"
>     },        \
>     +               { V4L2_BUF_TYPE_VIDEO_OVERLAY,      
>      "VIDEO_OVERLAY" },       \
>     +               { V4L2_BUF_TYPE_VBI_CAPTURE,          "VBI_CAPTURE"
>     },         \
>     +               { V4L2_BUF_TYPE_VBI_OUTPUT,           "VBI_OUTPUT"
>     },          \
>     +               { V4L2_BUF_TYPE_SLICED_VBI_CAPTURE,  
>     "SLICED_VBI_CAPTURE" },  \
>     +               { V4L2_BUF_TYPE_SLICED_VBI_OUTPUT,  
>      "SLICED_VBI_OUTPUT" },   \
>     +               { V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY,
>     "VIDEO_OUTPUT_OVERLAY" },\
>     +               { V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>     "VIDEO_CAPTURE_MPLANE" },\
>     +               { V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>      "VIDEO_OUTPUT_MPLANE" }, \
>     +               { V4L2_BUF_TYPE_PRIVATE,              "PRIVATE" })
>     +
>     +#define show_field(field)                                          
>        \
>     +       __print_symbolic(field,                                    
>         \
>     +               { V4L2_FIELD_ANY,               "ANY" },            
>        \
>     +               { V4L2_FIELD_NONE,              "NONE" },          
>         \
>     +               { V4L2_FIELD_TOP,               "TOP" },            
>        \
>     +               { V4L2_FIELD_BOTTOM,            "BOTTOM" },        
>         \
>     +               { V4L2_FIELD_INTERLACED,        "INTERLACED" },    
>         \
>     +               { V4L2_FIELD_SEQ_TB,            "SEQ_TB" },        
>         \
>     +               { V4L2_FIELD_SEQ_BT,            "SEQ_BT" },        
>         \
>     +               { V4L2_FIELD_ALTERNATE,         "ALTERNATE" },      
>        \
>     +               { V4L2_FIELD_INTERLACED_TB,     "INTERLACED_TB" },  
>        \
>     +               { V4L2_FIELD_INTERLACED_BT,     "INTERLACED_BT" })
>     +
>     +#define show_timecode_type(type)                                  
>         \
>     +       __print_symbolic(type,                                      
>        \
>     +               { V4L2_TC_TYPE_24FPS,           "24FPS" },          
>        \
>     +               { V4L2_TC_TYPE_25FPS,           "25FPS" },          
>        \
>     +               { V4L2_TC_TYPE_30FPS,           "30FPS" },          
>        \
>     +               { V4L2_TC_TYPE_50FPS,           "50FPS" },          
>        \
>     +               { V4L2_TC_TYPE_60FPS,           "60FPS" })
>     +
>     +#define show_flags(flags)                                          
>              \
>     +       __print_flags(flags, "|",                                  
>               \
>     +               { V4L2_BUF_FLAG_MAPPED,              "MAPPED" },    
>              \
>     +               { V4L2_BUF_FLAG_QUEUED,              "QUEUED" },    
>              \
>     +               { V4L2_BUF_FLAG_DONE,                "DONE" },      
>              \
>     +               { V4L2_BUF_FLAG_KEYFRAME,            "KEYFRAME" },  
>              \
>     +               { V4L2_BUF_FLAG_PFRAME,              "PFRAME" },    
>              \
>     +               { V4L2_BUF_FLAG_BFRAME,              "BFRAME" },    
>              \
>     +               { V4L2_BUF_FLAG_ERROR,               "ERROR" },    
>               \
>     +               { V4L2_BUF_FLAG_TIMECODE,            "TIMECODE" },  
>              \
>     +               { V4L2_BUF_FLAG_PREPARED,            "PREPARED" },  
>              \
>     +               { V4L2_BUF_FLAG_NO_CACHE_INVALIDATE,
>     "NO_CACHE_INVALIDATE" }, \
>     +               { V4L2_BUF_FLAG_NO_CACHE_CLEAN,    
>      "NO_CACHE_CLEAN" },      \
>     +               { V4L2_BUF_FLAG_TIMESTAMP_MASK,    
>      "TIMESTAMP_MASK" },      \
>     +               { V4L2_BUF_FLAG_TIMESTAMP_UNKNOWN,  
>     "TIMESTAMP_UNKNOWN" },   \
>     +               { V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC,
>     "TIMESTAMP_MONOTONIC" }, \
>     +               { V4L2_BUF_FLAG_TIMESTAMP_COPY,      "TIMESTAMP_COPY" })
>     +
>     +#define show_timecode_flags(flags)                                
>           \
>     +       __print_flags(flags, "|",                                  
>           \
>     +               { V4L2_TC_FLAG_DROPFRAME,       "DROPFRAME" },      
>          \
>     +               { V4L2_TC_FLAG_COLORFRAME,      "COLORFRAME" },    
>           \
>     +               { V4L2_TC_USERBITS_USERDEFINED,
>     "USERBITS_USERDEFINED" }, \
>     +               { V4L2_TC_USERBITS_8BITCHARS,   "USERBITS_8BITCHARS" })
>     +
>     +#define V4L2_TRACE_EVENT(event_name)                              
>         \
>     +       TRACE_EVENT(event_name,                                    
>         \
>     +               TP_PROTO(int minor, struct v4l2_buffer *buf),      
>         \
>     +                                                                  
>         \
>     +               TP_ARGS(minor, buf),                                
>        \
>     +                                                                  
>         \
>     +               TP_STRUCT__entry(                                  
>         \
>     +                       __field(int, minor)                        
>         \
>     +                       __field(u32, index)                        
>         \
>     +                       __field(u32, type)                          
>        \
>     +                       __field(u32, bytesused)                    
>         \
>     +                       __field(u32, flags)                        
>         \
>     +                       __field(u32, field)                        
>         \
>     +                       __field(s64, timestamp)                    
>         \
>     +                       __field(u32, timecode_type)                
>         \
>     +                       __field(u32, timecode_flags)                
>        \
>     +                       __field(u8, timecode_frames)                
>        \
>     +                       __field(u8, timecode_seconds)              
>         \
>     +                       __field(u8, timecode_minutes)              
>         \
>     +                       __field(u8, timecode_hours)                
>         \
>     +                       __field(u8, timecode_userbits0)            
>         \
>     +                       __field(u8, timecode_userbits1)            
>         \
>     +                       __field(u8, timecode_userbits2)            
>         \
>     +                       __field(u8, timecode_userbits3)            
>         \
>     +                       __field(u32, sequence)                      
>        \
>     +               ),                                                  
>        \
>     +                                                                  
>         \
>     +               TP_fast_assign(                                    
>         \
>     +                       __entry->minor = minor;                    
>         \
>     +                       __entry->index = buf->index;                
>        \
>     +                       __entry->type = buf->type;                  
>        \
>     +                       __entry->bytesused = buf->bytesused;        
>        \
>     +                       __entry->flags = buf->flags;                
>        \
>     +                       __entry->field = buf->field;                
>        \
>     +                       __entry->timestamp =                        
>        \
>     +                               timeval_to_ns(&buf->timestamp);    
>         \
>     +                       __entry->timecode_type = buf->timecode.type;
>        \
>     +                       __entry->timecode_flags =
>     buf->timecode.flags;  \
>     +                       __entry->timecode_frames =                  
>        \
>     +                               buf->timecode.frames;              
>         \
>     +                       __entry->timecode_seconds =                
>         \
>     +                               buf->timecode.seconds;              
>        \
>     +                       __entry->timecode_minutes =                
>         \
>     +                               buf->timecode.minutes;              
>        \
>     +                       __entry->timecode_hours =
>     buf->timecode.hours;  \
>     +                       __entry->timecode_userbits0 =              
>         \
>     +                               buf->timecode.userbits[0];          
>        \
>     +                       __entry->timecode_userbits1 =              
>         \
>     +                               buf->timecode.userbits[1];          
>        \
>     +                       __entry->timecode_userbits2 =              
>         \
>     +                               buf->timecode.userbits[2];          
>        \
>     +                       __entry->timecode_userbits3 =              
>         \
>     +                               buf->timecode.userbits[3];          
>        \
>     +                       __entry->sequence = buf->sequence;          
>        \
>     +               ),                                                  
>        \
>     +                                                                  
>         \
>     +               TP_printk("minor = %d, index = %u, type = %s, "    
>         \
>     +                         "bytesused = %u, flags = %s, "            
>        \
>     +                         "field = %s, timestamp = %llu, timecode =
>     { " \
>     +                         "type = %s, flags = %s, frames = %u, "    
>        \
>     +                         "seconds = %u, minutes = %u, hours = %u, "
>        \
>     +                         "userbits = { %u %u %u %u } }, "          
>        \
>     +                         "sequence = %u", __entry->minor,          
>        \
>     +                         __entry->index, show_type(__entry->type),
>         \
>     +                         __entry->bytesused,                      
>         \
>     +                         show_flags(__entry->flags),              
>         \
>     +                         show_field(__entry->field),              
>         \
>     +                         __entry->timestamp,                      
>         \
>     +                        
>     show_timecode_type(__entry->timecode_type),   \
>     +                        
>     show_timecode_flags(__entry->timecode_flags), \
>     +                         __entry->timecode_frames,                
>         \
>     +                         __entry->timecode_seconds,                
>        \
>     +                         __entry->timecode_minutes,                
>        \
>     +                         __entry->timecode_hours,                  
>        \
>     +                         __entry->timecode_userbits0,              
>        \
>     +                         __entry->timecode_userbits1,              
>        \
>     +                         __entry->timecode_userbits2,              
>        \
>     +                         __entry->timecode_userbits3,              
>        \
>     +                         __entry->sequence                        
>         \
>     +               )                                                  
>         \
>     +       )
>     +
>     +V4L2_TRACE_EVENT(v4l2_dqbuf);
>     +V4L2_TRACE_EVENT(v4l2_qbuf);
>     +
>     +#endif /* if !defined(_TRACE_V4L2_H) ||
>     defined(TRACE_HEADER_MULTI_READ) */
>     +
>     +/* This part must be outside protection */
>     +#include <trace/define_trace.h>
>     diff --git a/probes/Makefile b/probes/Makefile
>     index 63ca7ba..f98f2c5 100644
>     --- a/probes/Makefile
>     +++ b/probes/Makefile
>     @@ -197,6 +197,12 @@ obj-m +=  $(shell \
>                     echo "lttng-probe-sunrpc.o" ; fi;)
>      endif
> 
>     +ifneq ($(CONFIG_VIDEO_V4L2),)
>     +obj-m += $(shell \
>     +       if [ $(VERSION) -ge 3 -a $(PATCHLEVEL) -ge 14 ] ; then \
>     +               echo "lttng-probe-v4l2.o" ; fi;)
>     +endif
>     +
>      obj-m += lttng-probe-workqueue.o
> 
>      ifneq ($(CONFIG_KALLSYMS_ALL),)
>     diff --git a/probes/lttng-probe-v4l2.c b/probes/lttng-probe-v4l2.c
>     new file mode 100644
>     index 0000000..709ccb2
>     --- /dev/null
>     +++ b/probes/lttng-probe-v4l2.c
>     @@ -0,0 +1,44 @@
>     +/*
>     + * probes/lttng-probe-v4l2.c
>     + *
>     + * LTTng v4l2 probes.
>     + *
>     + * Copyright (C) 2010-2012 Mathieu Desnoyers
>     <mathieu.desnoyers@efficios.com <mailto:mathieu.desnoyers@efficios.com>>
>     + * Copyright (C) 2012,2013 Mentor Graphics Corp.
>     + *
>     + * This library is free software; you can redistribute it and/or
>     + * modify it under the terms of the GNU Lesser General Public
>     + * License as published by the Free Software Foundation; only
>     + * version 2.1 of the License.
>     + *
>     + * This library is distributed in the hope that it will be useful,
>     + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>     + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
>     + * Lesser General Public License for more details.
>     + *
>     + * You should have received a copy of the GNU Lesser General Public
>     + * License along with this library; if not, write to the Free Software
>     + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
>     02110-1301 USA
>     + */
>     +
>     +#include <linux/module.h>
>     +#include <linux/videodev2.h>
>     +
>     +/*
>     + * Create the tracepoint static inlines from the kernel to validate
>     that our
>     + * trace event macros match the kernel we run on.
>     + */
>     +#include <trace/events/v4l2.h>
>     +
>     +/*
>     + * Create LTTng tracepoint probes.
>     + */
>     +#define LTTNG_PACKAGE_BUILD
>     +#define CREATE_TRACE_POINTS
>     +#define TRACE_INCLUDE_PATH ../instrumentation/events/lttng-module
>     +
>     +#include "../instrumentation/events/lttng-module/v4l2.h"
>     +
>     +MODULE_LICENSE("GPL and additional rights");
>     +MODULE_AUTHOR("Wade Farnsworth <wade_farnsworth@mentor.com
>     <mailto:wade_farnsworth@mentor.com>>");
>     +MODULE_DESCRIPTION("LTTng v4l2 probes");
>     --
>     1.9.0
> 
> 
>     _______________________________________________
>     lttng-dev mailing list
>     lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>     http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> 


-- 
Wade Farnsworth
Sr. Embedded Linux Dev. Engr.
Mentor Embedded Software Division
www.mentor.com/embedded
