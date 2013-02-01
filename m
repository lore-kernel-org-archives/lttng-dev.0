From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace 1/2] Added Python 3.0 or better
 requirement to the README file
Date: Fri, 1 Feb 2013 13:54:57 +0000
Message-ID: <CA+jJMxv0tcbzd0m27586h_D3fY9e6-0Nd8Mt=-iKUOkcCH6E5g__6539.73233788765$1359726948$gmane$org@mail.gmail.com>
References: <1359640251-6133-1-git-send-email-jeremie.galarneau@efficios.com>
	<510BA252.3020604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f181.google.com ([74.125.82.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1U1H55-0003WW-QQ
	for lttng-dev@lists.lttng.org; Fri, 01 Feb 2013 08:55:04 -0500
Received: by mail-we0-f181.google.com with SMTP id t44so2946831wey.26
	for <lttng-dev@lists.lttng.org>; Fri, 01 Feb 2013 05:54:58 -0800 (PST)
In-Reply-To: <510BA252.3020604@gmail.com>
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

As for as I know, the bindings do work with Python 2.7.
However, we have decided to no longer explicitly support older
versions of Python in order to make the bindings, along with future
developments, easily maintainable.

Regards,
J=E9r=E9mie

On Fri, Feb 1, 2013 at 11:09 AM, Yannick Brosseau
<yannick.brosseau@gmail.com> wrote:
> On 2013-02-01 00:50, J=E9r=E9mie Galarneau wrote:
>> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
>> ---
>>  README | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/README b/README
>> index 9df02e7..ce98e24 100644
>> --- a/README
>> +++ b/README
>> @@ -49,6 +49,8 @@ To compile Babeltrace, you will need:
>>         (Debian/Ubuntu : python-dev)
>>       swig >=3D 2.0 (optional)
>>         (Debian/Ubuntu : swig2.0)
>> +     python 3.0 or better (optional)
>> +       (Debian/Ubuntu : python3)
> We really need python 3.0 to run the bindings now?
>
>>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
