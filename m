From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] trace: drop LTTng Userspace Tracer backend
Date: Thu, 26 Sep 2013 10:47:54 +0100
Message-ID: <8761tnzzgn.fsf@linaro.org>
References: <1380101319-29435-1-git-send-email-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-reply-to: <1380101319-29435-1-git-send-email-stefanha@redhat.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: lttng-dev@lists.lttng.org, qemu-devel@nongnu.org, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>
List-Id: lttng-dev@lists.lttng.org


stefanha@redhat.com writes:

> The current LTTng Userspace Tracer backend does not build against modern
> libraries.  LTTng has changed the library ABI several times, making it
> difficult to support this backend.

Looks good to me.

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed by: Alex Bennée <alex@bennee.com>

-- 
Alex Bennée
