From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Babeltrace v1.0.3
Date: Fri, 8 Mar 2013 13:14:20 -0500
Message-ID: <CA+jJMxtQuPFH+xXsG5DTn53+pr9M6nD2Eocxj9vNhSLZ-a0qSA__40007.5317397297$1362766533$gmane$org@mail.gmail.com>
References: <CAJ0F+TpPvT+ZLZO3jx2_fto5KXNLFBzekdRf+dg3n6MJPWfCNQ@mail.gmail.com>
	<CA+jJMxsRt_2LcjUzKgBbfvq_srLL_f7ZUEfrV0SO+jq8dEOtew@mail.gmail.com>
	<CAJ0F+Tr6R4JRAEfYB-+dArRXDtjGykKrN7EQbF7xk9HrH_8EKA@mail.gmail.com>
	<CA+jJMxuhrpZn64hwYW_qC7D61+UJVf3e8=rnCMF+frGT-kCzrA@mail.gmail.com>
	<CAJ0F+ToXt7Pe8KcqoDXaPuyy6dqzinzXfqcgOtKpQMOPhNV1Dg@mail.gmail.com>
	<CA+jJMxu4k7E-Ec2fJriJ-GXW9Sa0N8tx4ofidX2iWHhfsT=z3Q@mail.gmail.com>
	<CAJ0F+TqCmj0vSuHeUMreLUaNx0iP3dkjXEnj932WQgxAARdhAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f45.google.com ([209.85.215.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UE1oI-00081S-VP
	for lttng-dev@lists.lttng.org; Fri, 08 Mar 2013 13:14:27 -0500
Received: by mail-la0-f45.google.com with SMTP id er20so1977297lab.18
	for <lttng-dev@lists.lttng.org>; Fri, 08 Mar 2013 10:14:20 -0800 (PST)
In-Reply-To: <CAJ0F+TqCmj0vSuHeUMreLUaNx0iP3dkjXEnj932WQgxAARdhAw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Nikitha Annaji <nikitha.annaji@vayavyalabs.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Taking this back on the mailing list for public reference.

I was able to reproduce the "babeltrace: symbol lookup error:
babeltrace: undefined symbol: opt_clock_cycles" issue on Ubuntu 12.04
after installing the babeltrace package.

Looking at the package's information page[1], it appears that the it
depends on both libbabeltrace-ctf0 and libbabeltrace0 packages.
Issuing "sudo apt-get purge babeltrace" will not remove them and the
v1.0.0-rc1 libraries left on the system will conflict with the ones
you are installing from the 1.0.3 source package.

Removing these left-over packages (libbabeltrace-ctf0 and
libbabeltrace0) explicitly using "apt-get remove/purge" solved the
problem here. Let me know if it helps.

Regards,
J=E9r=E9mie

[1]  http://packages.ubuntu.com/precise/babeltrace

On Fri, Mar 8, 2013 at 12:00 AM, Nikitha Annaji
<nikitha.annaji@vayavyalabs.com> wrote:
> Hello,
>
> Yes, I uninstalled it.
>
> Actually  this  Babeltrace (1.0.0-rc1) package was along with ubuntu 12.0=
4.
> So I uninstalled it using the command " sudo apt-get purge lttng" and
> then installed Babeltrace v1.0.3.
>
> Now also am getting this  error :(
>
> On Fri, Mar 8, 2013 at 12:40 AM, J=E9r=E9mie Galarneau
> <jeremie.galarneau@efficios.com> wrote:
>> Did you uninstall the previous version of Babeltrace (1.0.0-rc1)?
>>
>> If not, please run "sudo make uninstall" in 1.0.0-rc1's source
>> directory to remove any trace of Babeltrace before you install the
>> newest version. (or using your distro's package manager, if you had
>> installed the babeltrace package)
>>
>> Please let me know if you still get this error at this point.
>>
>> J=E9r=E9mie
>>
>> On Wed, Mar 6, 2013 at 11:46 PM, Nikitha Annaji
>> <nikitha.annaji@vayavyalabs.com> wrote:
>>> Hello,
>>>
>>> I am using ubuntu 12.04 .
>>> As I told I just downloaded the package from https://lttng.org/download,
>>> extracted and builded by the below steps  :
>>>
>>>   1. ./configure
>>>   2. make
>>>   3. sudo make install
>>>   4. sudo ldconfig
>>>
>>> By using LTTNG i was able to reproduce the log (
>>> final-7351-20130219-153152 ) which is in CTF format. Then i was trying
>>> to use Babeltrace to convert above 'ctf log' into 'text' by giving the
>>> option as,
>>>
>>> babeltrace final-7351-20130219-153152
>>>
>>> Then i got This error. But if I switch to version v1.0.0-rc1 then it
>>> is working fine.
>>>
>>>
>>>
>>> On Wed, Mar 6, 2013 at 11:25 PM, J=E9r=E9mie Galarneau
>>> <jeremie.galarneau@efficios.com> wrote:
>>>> Hi,
>>>>
>>>> All available source code documentation is available in the doc folder
>>>> of the release tarball. However, the CTF spec itself is available at:
>>>>
>>>> http://git.efficios.com/?p=3Dctf.git;a=3Dblob_plain;f=3Dcommon-trace-f=
ormat-specification.txt;hb=3Dmaster
>>>>
>>>> I could not reproduce your issue here. Which ubuntu version are you
>>>> using and can you provide me with reproduction steps? What is the
>>>> exact command you are issuing to get babeltrace to error out?
>>>>
>>>> Regards,
>>>> J=E9r=E9mie
>>>>
>>>> On Wed, Mar 6, 2013 at 1:22 AM, Nikitha Annaji
>>>> <nikitha.annaji@vayavyalabs.com> wrote:
>>>>> Hi Jeremie ,
>>>>>
>>>>> I need one more help.
>>>>> Is their any documentation on source code of babeltrace version v1.0.=
0-rc1 .
>>>>>
>>>>> It will be a great help if you provide me the documentation because am
>>>>> not able to understand the source code.
>>>>>
>>>>> Thanks in advance.
>>>>>
>>>>> Thanks & Regards
>>>>> Nikitha Annaji
>>>>>
>>>>>
>>>>> On Wed, Mar 6, 2013 at 12:08 AM, J=E9r=E9mie Galarneau
>>>>> <jeremie.galarneau@efficios.com> wrote:
>>>>>> Hi Nikitha,
>>>>>>
>>>>>> I'd be glad to help you but I need more details. On which platform a=
re
>>>>>> you getting this error?
>>>>>>
>>>>>> Are you using a pre-compiled package from your distribution or did y=
ou
>>>>>> build babeltrace yourself?
>>>>>> If you compiled it yourself, which configuration options did you use?
>>>>>>
>>>>>> Regards,
>>>>>> J=E9r=E9mie
>>>>>>
>>>>>> On Tue, Mar 5, 2013 at 8:41 AM, Nikitha Annaji
>>>>>> <nikitha.annaji@vayavyalabs.com> wrote:
>>>>>>>  Hi,
>>>>>>> I was using the babeltrace version v1.0.0-rc1 and it use to produce
>>>>>>> the text log when we give the ctf input,
>>>>>>> but when i switched Babeltrace to the newer version it is started
>>>>>>> giving this error : babeltrace: symbol lookup error: babeltrace:
>>>>>>> undefined symbol: opt_clock_cycles . Can you please tell me what
>>>>>>> should be done so that i will not get this error again.
>>>>>>>
>>>>>>> Thanks & Regards
>>>>>>> Nikitha Annaji
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> lttng-dev mailing list
>>>>>>> lttng-dev@lists.lttng.org
>>>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>>
>>> --
>>> Thanks & Regards
>>> Nikitha Annaji
>
>
>
> --
> Thanks & Regards
> Nikitha Annaji
