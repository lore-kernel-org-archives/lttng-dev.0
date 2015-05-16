From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: (no subject)
Date: Sat, 16 May 2015 11:35:20 -0400
Message-ID: <555763B8.3010804__8221.43139453164$1431790594$gmane$org@voxpopuli.im>
References: <CAG4vvd49JfNUgN9p9vW0bQXoRkBjER74zVbTAg-CmtETZeDn2Q@mail.gmail.com>
 <CAFXXi0kf0aWS7vS9m8HmdPoXR3RL=bjtaL_y+coR7T2npE=eWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1Yte7d-0005Eg-O2
 for lttng-dev@lists.lttng.org; Sat, 16 May 2015 11:35:36 -0400
In-Reply-To: <CAFXXi0kf0aWS7vS9m8HmdPoXR3RL=bjtaL_y+coR7T2npE=eWQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>, Francis Rivest <francis.rivest13@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hey,

Ok, after some investigation, I found the problem.

We specify "*" in the .install file, so I was wondering why that script 
was not being installed. Turns out that it gets ignored because it 
contains "debian" in its name. I assume the package building scripts 
want to ignore any debian/ folder that may be present in the original 
source. To do this, they probably use an unbounded regex, which also 
ignores anything that contains "debian". Oops!

If we rename that script to abi-version.sh for instance, both the file 
name and in the Makefile, then it installs fine. So I think the easiest 
is just to rename the script (either with a package patch, or upstream 
if they want to change it).

I get another compilation error on Vivid's kernel though, I'll look into 
that next.

Cheers,
Alexandre



On 2015-05-14 05:14 PM, Simon Marchi wrote:
> Ah, this is because we need to add abi-debian-version.sh to the Ubuntu
> package. I don't have time to do it right away, but perhaps Alexandre
> (in CC) does :).
>
> On 14 May 2015 at 15:33, Francis Rivest <francis.rivest13@gmail.com> wrote:
>> Hello again,
>>
>> We tried to install the lttng-modules-dkms package using apt and the
>> "ppa:lttng/ppa" repository, but we get the following information and error:
>>
>> Unpacking lttng-modules-dkms (from .../lttng-modules-dkms_2.6.x+
>> stable+bzr727+pack22+201504291801~ubuntu12.04.1_all.deb) ...
>> Setting up lttng-modules-dkms
>> (2.6.x+stable+bzr727+pack22+201504291801~ubuntu12.04.1)
>> ...
>> Loading new
>> lttng-modules-2.6.x+stable+bzr727+pack22+201504291801~ubuntu12.04.1
>> DKMS files...
>> First Installation: checking all kernels...
>> Building only for 3.13.0-32-generic
>> Building initial module for 3.13.0-32-generic
>> Error! Bad return status for module build on kernel: 3.13.0-32-generic
>> (x86_64)
>> Consult /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
>> 201504291801~ubuntu12.04.1/build/make.log for more information.
>>
>>
>> The contain of the make.log file is the following:
>>
>> DKMS make.log for
>> lttng-modules-2.6.x+stable+bzr727+pack22+201504291801~ubuntu12.04.1
>> for kernel 3.13.0-32-generic (x86_64)
>> Thu May 14 15:00:16 EDT 2015
>> make: Entering directory `/usr/src/linux-headers-3.13.0-32-generic'
>> /bin/sh: 1: /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
>> 201504291801~ubuntu12.04.1/build/abi-debian-version.sh: not found
>> /bin/sh: 1: /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
>> 201504291801~ubuntu12.04.1/build/abi-debian-version.sh: not found
>>     CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
>> 201504291801~ubuntu12.04.1/build/lttng-ring-buffer-client-discard.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
>> 201504291801~ubuntu12.04.1/build/lttng-ring-buffer-client-overwrite.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
>> 201504291801~ubuntu12.04.1/build/lttng-ring-buffer-metadata-client.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
>> 201504291801~ubuntu12.04.1/build/lttng-ring-buffer-client-mmap-discard.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
>> 201504291801~ubuntu12.04.1/build/lttng-ring-buffer-client-mmap-overwrite.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
>> 201504291801~ubuntu12.04.1/build/lttng-ring-buffer-metadata-mmap-client.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
>> 201504291801~ubuntu12.04.1/build/lttng-statedump-impl.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
>> 201504291801~ubuntu12.04.1/build/wrapper/irqdesc.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
>> 201504291801~ubuntu12.04.1/build/wrapper/fdtable.o
>>     CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
>> 201504291801~ubuntu12.04.1/build/lttng-events.o
>> In file included from /var/lib/dkms/lttng-modules/2.
>> 6.x+stable+bzr727+pack22+201504291801~ubuntu12.04.1/
>> build/lttng-events.c:27:0:
>> /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
>> 201504291801~ubuntu12.04.1/build/wrapper/page_alloc.h:36:58: error:
>> operator '+' has no right operand
>> make[1]: *** [/var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
>> 201504291801~ubuntu12.04.1/build/lttng-events.o] Error 1
>> make: *** [_module_/var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+
>> pack22+201504291801~ubuntu12.04.1/build] Error 2
>> make: Leaving directory `/usr/src/linux-headers-3.13.0-32-generic'
>>
>>
>> We know that "abi-debian-version.sh" isn't found and that might be the
>> cause of our problem but it is supposed to be in the package...
>>
>> In addition we tried to include manually this file but it didn't work.
>>
>> Thanks again for helping me out.
>>
>> -Francis R
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
