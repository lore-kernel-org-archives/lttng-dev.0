From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: Remove extra quote after an
 include directive
Date: Wed, 15 May 2013 13:01:01 -0400
Message-ID: <CA+jJMxv2ApjX7RM6UdvRggSp-K1ApJfobsXtqrMFu0T++_Y0pQ__23371.634601108$1368637303$gmane$org@mail.gmail.com>
References: <1368635955-13695-1-git-send-email-jeremie.galarneau@efficios.com>
	<20130515165030.GA10924@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Ucf4d-000707-1n
	for lttng-dev@lists.lttng.org; Wed, 15 May 2013 13:01:07 -0400
Received: by mail-wi0-f169.google.com with SMTP id hn14so3229547wib.4
	for <lttng-dev@lists.lttng.org>; Wed, 15 May 2013 10:01:01 -0700 (PDT)
In-Reply-To: <20130515165030.GA10924@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

It was introduced here:
https://bugs.lttng.org/projects/babeltrace/repository/revisions/4cb26dfbd76=
3c06d99bf1069e2d1f3a569858e32/diff

On Wed, May 15, 2013 at 12:50 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> in which tree did you find this ?
>
> * J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
>> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
>> ---
>>  formats/ctf/ctf.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
>> index b27f2ec..bb94e52 100644
>> --- a/formats/ctf/ctf.c
>> +++ b/formats/ctf/ctf.c
>> @@ -51,7 +51,7 @@
>>  #include "metadata/ctf-parser.h"
>>  #include "metadata/ctf-ast.h"
>>  #include "events-private.h"
>> -#include <babeltrace/compat/memstream.h>"
>> +#include <babeltrace/compat/memstream.h>
>>
>>  #define LOG2_CHAR_BIT        3
>>
>> --
>> 1.8.2.2
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
