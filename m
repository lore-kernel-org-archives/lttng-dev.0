From: Corey Minyard <tcminyard@gmail.com>
Subject: put_ulong calls in lib_ring_buffer_compat_ioctl()
	should be compat?
Date: Tue, 11 Dec 2012 16:17:52 -0600
Message-ID: <50C7B110.3040009__5447.09918690405$1355264648$gmane$org@acm.org>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gg0-f176.google.com ([209.85.161.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <tcminyard@gmail.com>) id 1TiY9J-0002rl-HV
	for lttng-dev@lists.lttng.org; Tue, 11 Dec 2012 17:18:01 -0500
Received: by mail-gg0-f176.google.com with SMTP id h3so872599gge.35
	for <lttng-dev@lists.lttng.org>; Tue, 11 Dec 2012 14:17:56 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

I was noticing the that some of the put_ulong calls in 
lib_ring_buffer_compat_ioctl() were not compat_put_ulong.  I can't 
imagine this is correct.  Here's a patch to fix it, assuming that is 
wrong.  It seems to work ok.

diff --git a/lib/ringbuffer/ring_buffer_vfs.c 
b/lib/ringbuffer/ring_buffer_vfs.c
index c69b64e..899af81 100644
--- a/lib/ringbuffer/ring_buffer_vfs.c
+++ b/lib/ringbuffer/ring_buffer_vfs.c
@@ -331,7 +331,7 @@ long lib_ring_buffer_compat_ioctl(struct file *filp, 
unsigned int cmd,
          data_size = lib_ring_buffer_get_read_data_size(config, buf);
          if (data_size > UINT_MAX)
              return -EFBIG;
-        return put_ulong(data_size, arg);
+        return compat_put_ulong(data_size, arg);
      }
      case RING_BUFFER_COMPAT_GET_PADDED_SUBBUF_SIZE:
      {
@@ -341,12 +341,12 @@ long lib_ring_buffer_compat_ioctl(struct file 
*filp, unsigned int cmd,
          size = PAGE_ALIGN(size);
          if (size > UINT_MAX)
              return -EFBIG;
-        return put_ulong(size, arg);
+        return compat_put_ulong(size, arg);
      }
      case RING_BUFFER_COMPAT_GET_MAX_SUBBUF_SIZE:
          if (chan->backend.subbuf_size > UINT_MAX)
              return -EFBIG;
-        return put_ulong(chan->backend.subbuf_size, arg);
+        return compat_put_ulong(chan->backend.subbuf_size, arg);
      case RING_BUFFER_COMPAT_GET_MMAP_LEN:
      {
          unsigned long mmap_buf_len;
@@ -358,7 +358,7 @@ long lib_ring_buffer_compat_ioctl(struct file *filp, 
unsigned int cmd,
              mmap_buf_len += chan->backend.subbuf_size;
          if (mmap_buf_len > UINT_MAX)
              return -EFBIG;
-        return put_ulong(mmap_buf_len, arg);
+        return compat_put_ulong(mmap_buf_len, arg);
      }
      case RING_BUFFER_COMPAT_GET_MMAP_READ_OFFSET:
      {
@@ -371,7 +371,7 @@ long lib_ring_buffer_compat_ioctl(struct file *filp, 
unsigned int cmd,
          read_offset = buf->backend.array[sb_bindex]->mmap_offset;
          if (read_offset > UINT_MAX)
              return -EINVAL;
-        return put_ulong(read_offset, arg);
+        return compat_put_ulong(read_offset, arg);
      }
      case RING_BUFFER_COMPAT_FLUSH:
          lib_ring_buffer_switch_slow(buf, SWITCH_ACTIVE);
