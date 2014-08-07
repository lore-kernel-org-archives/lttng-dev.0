From: =?UTF-8?Q?J=C3=A9r=C3=A9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Bug#751337: [PATCH] tests: test_ctf_writer: replace HOST_NAME_MAX
Date: Thu, 7 Aug 2014 15:07:08 -0400
Message-ID: <CA+jJMxv2baZmUL=jG1UOXoCm6jHVVzQt6bO_=jDmny+-UX_8xQ__2264.00077012858$1407438563$gmane$org@mail.gmail.com>
References: <20140805200251.GA17716@breakpoint.cc>
	<20140805201412.GA11272@helmut>
	<20140806070324.GA2888@breakpoint.cc>
Reply-To: =?UTF-8?Q?J=C3=A9r=C3=A9mie?= Galarneau <jeremie.galarneau@efficios.com>, 751337@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-bugs-rc=glddbr-debian-bugs-rc=gmane.org@lists.debian.org>
Sender: jeremie.galarneau@gmail.com
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.751337.B751337.14074384368619@bugs.debian.org>
Sender: jeremie.galarneau@gmail.com
In-Reply-To: <20140806070324.GA2888@breakpoint.cc>
List-URL: <http://lists.debian.org/debian-bugs-rc/>
List-Post: <mailto:debian-bugs-rc@lists.debian.org>
List-Help: <mailto:debian-bugs-rc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-rc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-rc-request@lists.debian.org?subject=unsubscribe>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: 751337@bugs.debian.org, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Fixed in both master (as of 22843b6) and stable 1.2 (as of 0954670) branche=
s.

On Wed, Aug 6, 2014 at 3:03 AM, Sebastian Andrzej Siewior
<sebastian@breakpoint.cc> wrote:
> On 2014-08-05 16:14:12 [-0400], Jon Bernard wrote:
>> This may also work as well:
>>
>>     diff --git a/configure.ac b/configure.ac
>>     index 80eba33..248044e 100644
>>     --- a/configure.ac
>>     +++ b/configure.ac
>>     @@ -50,6 +50,17 @@ AC_C_INLINE
>>      AC_TYPE_PID_T
>>      AC_TYPE_SIZE_T
>>
>>     +# FreeBSD does not define HOST_NAME_MAX
>>     +AC_CHECK_DECL(HOST_NAME_MAX,,
>>     +       [
>>     +        AC_CHECK_DECL(_POSIX_HOST_NAME_MAX,
>>     +                      AC_DEFINE(HOST_NAME_MAX, _POSIX_HOST_NAME_MAX=
, []),
>>     +                      AC_DEFINE(HOST_NAME_MAX, 256, [Define to 256 =
if neither have HOST_NAME_MAX nor _POSIX_HOST_NAME_MAX]),
>>     +                      [[#include <limits.h>]])
>>     +       ],
>>     +       [[#include <limits.h>]]
>>     +)
>
> Sure it will. I have no strong opinion on how it gets fixed :)
>
>>     +
>>      # Checks for library functions.
>>      AC_FUNC_MALLOC
>>      AC_FUNC_MMAP
>>
>
> Sebastian



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
