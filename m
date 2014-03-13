From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: Prototype MI
Date: Thu, 13 Mar 2014 16:51:46 -0400
Message-ID: <20140313205145.GA3964__11796.8983635821$1394743994$gmane$org@gmail.com>
References: <CAF4oYfGcZpUmEPQHiDbXLx8v7-RY=7RY7rStZKR_9LXcPuZCWg@mail.gmail.com>
	<CA+jJMxsFH5J1E5uNKXqwK7Uczip4Am8TmeQqPeeM+s2n792iew@mail.gmail.com>
	<20140313160050.GD8473@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jonathan.r.julien@gmail.com>) id 1WOCbb-00078I-KE
	for lttng-dev@lists.lttng.org; Thu, 13 Mar 2014 16:52:03 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so1548412ieb.26
	for <lttng-dev@lists.lttng.org>; Thu, 13 Mar 2014 13:51:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140313160050.GD8473@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, =?iso-8859-1?Q?Genevi=E8ve?= Bastien <genevieve.bastien@polymtl.ca>, Olivier Moussavou Cotte <omcotte@gmail.com>
List-Id: lttng-dev@lists.lttng.org

On Thu, Mar 13, 2014 at 12:00:50PM -0400, David Goulet wrote:
> Hey!
> =

> (putting lttng-dev in CC, this is a very relevant discussion that should
> be public).
> =

> Something I'm wondering here before we go further. Is this code wouldn't
> be better off in libconfig (src/common/config)?
> =

> A reason would be to have it available in a library maybe at some point
> in time like for instance "lttng_list_sessions(int output_format, ...)"
> and output_format is set to XML for example.
As discussed on the IRC, adding a global or command specific option for
MI that promote different output format does not add any complexity. So
the final option will be :  --mi <output_format>. XML will be the
default. So "lttng_list_sessions(int output_format, ...)" make sense.

> =

> One of the problem right now due to a very limited public API we have to
> cope with is the fact that right now, on the lttng client side, we can't
> list everything so this mi interface will only be used for a subset of
> what we can offer to the user (which the save feature addresses being on
> the session daemon side).
> =

> I'm not saying that we should reimplement the whole API with new
> functions that sends back the mi output but at least in term of code
> location in the repository, it could be a good idea to think that not
> only the lttng command line might use it *especially* since libconfig is
> almost doing the same thing for the save/load feature.
Make sense to move it there, sure the 'libconfig' name isn't
representative of MI but for now the MI would be highly dependant on the
libxml wrapper present in config.h. After all the point of an MI is to
standardize communications between application and putting it in a common
lib does promote standardization.
> =

> Food for thoughts ;)
> =

> Oh one thing, last path, all switch cases are tabbed for no reason,
> maybe your editor did that automagically ? ;)
Magic :P (let say we have to re-read the coding Style...)
> =

> Cheers!
> David
> =

And now the code review :)
> On 13 Mar (11:45:33), J=E9r=E9mie Galarneau wrote:
> > Hi,
> > =

> > Inlining the first patch, see comments throughout. I'll review the
> > other patches in separate e-mails.
> > =

> > Is there a reason why you define an mi_writer wrapper over
> > config_writer? Do you expect you'll redefine "mi_writer" as a
> > full-fledged structure (instead of a typedef)?
At first we did this only to separate us from the 'config' nomenclature.
We did not expect to redefine it but with the appearance of
error handling and temporary file management we currently have redefined
it to a full-fledged structure.
> > =

> > Also, mi-internal.h and mi.h can be merged if you don't plan on making
> > them public. We typically only define "*-internal.h" headers when
> > there is already an equivalent public header already.
Understood
> > =

> > Finally, please run the checkpatch.pl script in lttng-tools/extras/ on
> > your patches. It will point out most style issues.
> > =


Will do as for all the style annotations.
> > Regards,
> > J=E9r=E9mie
> > =

> > > From 205eeaf19d0246b6db0517d9c22727b82f5e444e Mon Sep 17 00:00:00 2001
> > > From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> > > Date: Fri, 7 Mar 2014 09:22:13 -0500
> > > Subject: [PATCH 1/3] MI: basic mi utility function
> > >
> > >
> > > Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> > > ---
> > >  src/bin/lttng/Makefile.am   |    1 +
> > >  src/bin/lttng/mi-internal.h |   69 ++++++++++++++++++++
> > >  src/bin/lttng/mi.c          |  130 +++++++++++++++++++++++++++++++++=
++++
> > >  src/bin/lttng/mi.h          |  150 +++++++++++++++++++++++++++++++++=
++++++++++
> > >  4 files changed, 350 insertions(+)
> > >  create mode 100644 src/bin/lttng/mi-internal.h
> > >  create mode 100644 src/bin/lttng/mi.c
> > >  create mode 100644 src/bin/lttng/mi.h
> > >
> > > diff --git a/src/bin/lttng/Makefile.am b/src/bin/lttng/Makefile.am
> > > index 5a1eb6a..93c39fa 100644
> > > --- a/src/bin/lttng/Makefile.am
> > > +++ b/src/bin/lttng/Makefile.am
> > > @@ -16,6 +16,7 @@ lttng_SOURCES =3D command.h conf.c conf.h commands/=
start.c \
> > >                  commands/snapshot.c \
> > >                  commands/save.c \
> > >                  commands/load.c \
> > > +                mi.c \
> > >                  utils.c utils.h lttng.c
> > >
> > >  lttng_LDADD =3D $(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
> > > diff --git a/src/bin/lttng/mi-internal.h b/src/bin/lttng/mi-internal.h
> > > new file mode 100644
> > > index 0000000..346f715
> > > --- /dev/null
> > > +++ b/src/bin/lttng/mi-internal.h
> > > @@ -0,0 +1,69 @@
> > > +/*
> > > + * Copyright (C) 2014   - Jonathan Rajotte <jonathan.r.julien@gmail.=
com>
> > > + *                      - Olivier Cotte <olivier.cotte@polymtl.ca>
> > > + *
> > > + * This program is free software; you can redistribute it and/or mod=
ify it
> > > + * under the terms of the GNU General Public License, version 2 only=
, as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope that it will be useful, b=
ut WITHOUT
> > > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> > > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Lice=
nse for
> > > + * more details.
> > > + *
> > > + * You should have received a copy of the GNU General Public License=
 along with
> > > + * this program; if not, write to the Free Software Foundation, Inc.=
, 51
> > > + * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > > + */
> > > +
> > > +#ifndef MI_INTERNAL_H
> > > +#define MI_INTERNAL_H
> > > +
> > > +// Strings related to command
> > =

> > Don't use C99 comments, prefer the /* ... */ form
> > =

> > > +const char * const mi_element_command;
> > > +const char * const mi_element_command_version;
> > > +const char * const mi_element_command_list;
> > > +
> > > +// Strings related to command: version
> > =

> > Don't use C99 comments, prefer the /* ... */ form
> > =

> > > +const char * const mi_element_version_str;
> > > +const char * const mi_element_version_web;
> > > +const char * const mi_element_version_name;
> > > +const char * const mi_element_version_major;
> > > +const char * const mi_element_version_minor;
> > > +const char * const mi_element_version_license;
> > > +const char * const mi_element_version_patch_level;
> > > +const char * const mi_element_version_description;
> > > +
> > > +// Strings related to command: list -k (kernel)
> > =

> > Don't use C99 comments, prefer the /* ... */ form
> > =

> > > +const char * const mi_element_list_kernel_event_tracepoint;
> > > +const char * const mi_element_list_kernel_event_function;
> > > +const char * const mi_element_list_kernel_event_probe;
> > > +const char * const mi_element_list_kernel_event_function_entry;
> > > +const char * const mi_element_list_kernel_event_syscall;
> > > +const char * const mi_element_list_kernel_event_noop;
> > > +const char * const mi_element_list_kernel_event_all;
> > > +const char * const mi_element_list_events_flag;
> > > +const char * const mi_element_list_event_flag;
> > > +const char * const mi_element_list_event_type;
> > > +const char * const mi_element_list_event_name;
> > > +const char * const mi_element_list_loglevel_type;
> > > +const char * const mi_element_list_loglevel;
> > > +const char * const mi_element_list_event_enabled;
> > > +const char * const mi_element_list_event_exclusion;
> > > +const char * const mi_element_list_event_filter;
> > > +const char * const mi_element_list_loglevel_str;
> > > +const char * const mi_element_list_event_enabled_str;
> > > +const char * const mi_element_list_event_exclusion_str;
> > > +const char * const mi_element_list_event_filter_str;
> > > +const char * const mi_element_list_event_addr;
> > > +const char * const mi_element_list_event_offset;
> > > +const char * const mi_element_list_event_symbol;
> > > +
> > > +
> > =

> > Remove the extra whitespace.
> > =

> > > +// Strings related to command: list -u (userspace)
> > =

> > Don't use C99 comments, prefer the /* ... */ form
> > =

> > > +const char * const mi_element_list_ust_jul_events;
> > > +const char * const mi_element_list_ust_jul_event;
> > > +const char * const mi_element_list_ust_curr_pid;
> > > +const char * const mi_element_list_ust_cmdline;
> > > +
> > > +#endif /* MI_INTERNAL_H */
> > > diff --git a/src/bin/lttng/mi.c b/src/bin/lttng/mi.c
> > > new file mode 100644
> > > index 0000000..016b52a
> > > --- /dev/null
> > > +++ b/src/bin/lttng/mi.c
> > > @@ -0,0 +1,130 @@
> > > +/*
> > > + * Copyright (C) 2014   - Jonathan Rajotte <jonathan.r.julien@gmail.=
com>
> > > + *                      - Olivier Cotte <olivier.cotte@polymtl.ca>
> > > + *
> > > + * This program is free software; you can redistribute it and/or mod=
ify it
> > > + * under the terms of the GNU General Public License, version 2 only=
, as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope that it will be useful, b=
ut WITHOUT
> > > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> > > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Lice=
nse for
> > > + * more details.
> > > + *
> > > + * You should have received a copy of the GNU General Public License=
 along with
> > > + * this program; if not, write to the Free Software Foundation, Inc.=
, 51
> > > + * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > > + */
> > > +
> > > +#include <common/config/config.h>
> > > +#include "mi-internal.h"
> > > +#include "mi.h"
> > > +
> > =

> > Some of these strings are already defined in config.c. Is there a
> > reason why you redefine them here?
> > We could point to them at least.
We decided not to point to these because we considered the MI and
config(load-save) two different things, one internal(load/save) to sessiond
and the other one a public "interface". You could want more specifics
names for internals setting and more generics ones for MI.
> > =

> > David, any thoughts on this?
> > =

> > > +/* Strings related to command */
> > > +const char * const mi_element_command                           =3D =
"command";
> > > +const char * const mi_element_command_version                   =3D =
"version";
> > > +const char * const mi_element_command_list                      =3D =
"list";
> > > +
> > > +/* Strings related to command: version */
> > > +const char * const mi_element_version_str                       =3D =
"string";
> > > +const char * const mi_element_version_web                       =3D =
"url";
> > > +const char * const mi_element_version_name                      =3D =
"name";
> > > +const char * const mi_element_version_major                     =3D =
"major";
> > > +const char * const mi_element_version_minor                     =3D =
"minor";
> > > +const char * const mi_element_version_license                   =3D =
"license";
> > > +const char * const mi_element_version_patch_level               =3D =
"patchLevel";
> > > +const char * const mi_element_version_description               =3D =
"description";
> > > +
> > > +/* Strings related to command: list */
> > > +const char * const mi_element_list_kernel_event_tracepoint      =3D =
"TRACEPOINT";
> > > +const char * const mi_element_list_kernel_event_function        =3D =
"FUNCTION";
> > > +const char * const mi_element_list_kernel_event_probe           =3D =
"PROBE";
> > > +const char * const mi_element_list_kernel_event_function_entry  =3D =
"FUNCTION_ENTRY";
> > > +const char * const mi_element_list_kernel_event_syscall         =3D =
"SYSCALL";
> > > +const char * const mi_element_list_kernel_event_noop            =3D =
"NOOP";
> > > +const char * const mi_element_list_kernel_event_all             =3D =
"ALL";
> > > +const char * const mi_element_list_events_flag                  =3D =
"events";
> > > +const char * const mi_element_list_event_flag                   =3D =
"event";
> > > +const char * const mi_element_list_event_type                   =3D =
"type";
> > > +const char * const mi_element_list_event_name                   =3D =
"name";
> > > +const char * const mi_element_list_loglevel_type                =3D =
"loglevel_type";
> > > +const char * const mi_element_list_loglevel                     =3D =
"loglevel";
> > > +const char * const mi_element_list_event_enabled                =3D =
"enabled";
> > > +const char * const mi_element_list_event_exclusion              =3D =
"exclusion";
> > > +const char * const mi_element_list_event_filter                 =3D =
"filter";
> > > +const char * const mi_element_list_loglevel_str                 =3D =
"loglevel_string";
> > > +const char * const mi_element_list_event_enabled_str            =3D =
"enabled_string";
> > > +const char * const mi_element_list_event_exclusion_str          =3D =
"exclusion_string";
> > > +const char * const mi_element_list_event_filter_str             =3D =
"filter_string";
> > > +const char * const mi_element_list_event_addr                   =3D =
"addr";
> > > +const char * const mi_element_list_event_offset                 =3D =
"offset";
> > > +const char * const mi_element_list_event_symbol                 =3D =
"symbol";
> > > +
> > > +const char * const mi_element_list_ust_jul_events               =3D =
"jul_events";
> > > +const char * const mi_element_list_ust_jul_event                =3D =
"jul_event";
> > > +const char * const mi_element_list_ust_curr_pid                 =3D =
"curr_pid";
> > > +const char * const mi_element_list_ust_cmdline                  =3D =
"cmdline";
> > > +
> > =

> > Please add the LTTNG_HIDDEN annotation to all functions in this file.
> > =

> > > +mi_writer *mi_writer_create(int fd_output)
> > > +{
> > > +    //TODO JRJ: handle err ... with tmp file
> > > +    return config_writer_create(fd_output);
> > =

> > Use tabs instead of spaces. Applies throughout
> > =

> > > +}
> > > +
> > > +int mi_writer_destroy(mi_writer *writer)
> > > +{
> > > +    return config_writer_destroy(writer);
> > > +}
> > > +
> > > +int mi_writer_command_open(mi_writer *writer, const char* command)
> > =

> > Prefer
> > =

> > const char *command
> > =

> > to
> > =

> > const char* command.
> > =

> > > +{
> > > +    int ret;
> > > +    ret =3D mi_writer_open_element(writer, mi_element_command);
> > > +    if (ret) {
> > > +        goto end;
> > > +    }
> > > +    ret =3D mi_writer_open_element(writer, command);
> > > +end:
> > > +    return ret;
> > > +}
> > > +
> > > +int mi_writer_command_close(mi_writer *writer)
> > > +{
> > > +    return mi_writer_close_element(writer);
> > > +}
> > > +
> > > +int mi_writer_open_element(mi_writer *writer,
> > > +        const char *element_name)
> > > +{
> > > +    return config_writer_open_element(writer, element_name);
> > > +}
> > > +
> > > +int mi_writer_close_element(mi_writer *writer)
> > > +{
> > > +    return config_writer_close_element(writer);
> > > +}
> > > +
> > > +int mi_writer_write_element_unsigned_int(mi_writer *writer,
> > > +        const char *element_name, uint64_t value)
> > > +{
> > > +    return config_writer_write_element_unsigned_int(writer, element_=
name, value);
> > =

> > Line over 80 characters.
> > =

> > > +}
> > > +
> > > +int mi_writer_write_element_signed_int(mi_writer *writer,
> > > +        const char *element_name, int64_t value)
> > > +{
> > > +    return config_writer_write_element_signed_int(writer, element_na=
me, value);
> > > +}
> > > +
> > > +int mi_writer_write_element_bool(mi_writer *writer,
> > > +        const char *element_name, int value)
> > > +{
> > > +    return config_writer_write_element_bool(writer, element_name, va=
lue);
> > > +}
> > > +
> > > +int mi_writer_write_element_string(mi_writer *writer,
> > > +        const char *element_name, const char *value)
> > > +{
> > > +    return config_writer_write_element_string(writer, element_name, =
value);
> > > +}
> > > +
> > > diff --git a/src/bin/lttng/mi.h b/src/bin/lttng/mi.h
> > > new file mode 100644
> > > index 0000000..d509273
> > > --- /dev/null
> > > +++ b/src/bin/lttng/mi.h
> > > @@ -0,0 +1,150 @@
> > > +/*
> > > + * Copyright (C) 2014   - Jonathan Rajotte <jonathan.r.julien@gmail.=
com>
> > > + *                      - Olivier Cotte <olivier.cotte@polymtl.ca>
> > > + *
> > > + * This program is free software; you can redistribute it and/or mod=
ify it
> > > + * under the terms of the GNU General Public License, version 2 only=
, as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope that it will be useful, b=
ut WITHOUT
> > > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> > > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Lice=
nse for
> > > + * more details.
> > > + *
> > > + * You should have received a copy of the GNU General Public License=
 along with
> > > + * this program; if not, write to the Free Software Foundation, Inc.=
, 51
> > > + * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > > + */
> > > +
> > > +#ifndef _MI_H
> > > +#define _MI_H
> > > +
> > > +#include <common/config/config.h>
> > > +#include <common/error.h>
> > > +#include <common/macros.h>
> > > +#include <stdint.h>
> > > +
> > > +/* Instance of a machine interface writer. */
> > > +typedef struct config_writer mi_writer;
> > > +
> > > +/*
> > > + * Create an instance of a machine interface writer.
> > > + *
> > > + * fd_output File to which the XML content must be written. The file=
 will be
> > > + * closed once the mi_writer has been destroyed.
> > > + *
> > > + * Returns an instance of a machine interface writer on success, NUL=
L on
> > > + * error.
> > > + */
> > > +LTTNG_HIDDEN
> > > +mi_writer *mi_writer_create(int fd_output);
> > > +
> > > +/*
> > > + * Destroy an instance of a configuration writer.
> > > + *
> > > + * writer An instance of a configuration writer.
> > > + *
> > > + * Returns zero if the XML document could be closed cleanly. Negativ=
e values
> > > + * indicate an error.
> > > + */
> > > +LTTNG_HIDDEN
> > > +int mi_writer_destroy(mi_writer *writer);
> > > +
> > > +
> > > +LTTNG_HIDDEN
> > > +int mi_writer_command_open(mi_writer *writer, const char* command);
> > > +
> > > +LTTNG_HIDDEN
> > > +int mi_writer_command_close(mi_writer *writer);
> > > +
> > > +/*
> > > + * Open an element tag.
> > > + *
> > > + * writer An instance of a configuration writer.
> > > + *
> > > + * element_name Element tag name.
> > > + *
> > > + * Returns zero if the XML document could be closed cleanly.
> > > + * Negative values indicate an error.
> > > + */
> > > +LTTNG_HIDDEN
> > > +int mi_writer_open_element(mi_writer *writer,
> > > +        const char *element_name);
> > > +
> > > +/*
> > > + * Close the current element tag.
> > > + *
> > > + * writer An instance of a configuration writer.
> > > + *
> > > + * Returns zero if the XML document could be closed cleanly.
> > > + * Negative values indicate an error.
> > > + */
> > > +LTTNG_HIDDEN
> > > +int mi_writer_close_element(mi_writer *writer);
> > > +
> > > +/*
> > > + * Write an element of type unsigned int.
> > > + *
> > > + * writer An instance of a configuration writer.
> > > + *
> > > + * element_name Element name.
> > > + *
> > > + * value Unsigned int value of the element
> > > + *
> > > + * Returns zero if the element's value could be written.
> > > + * Negative values indicate an error.
> > > + */
> > > +LTTNG_HIDDEN
> > > +int mi_writer_write_element_unsigned_int(mi_writer *writer,
> > > +        const char *element_name, uint64_t value);
> > > +
> > > +/*
> > > + * Write an element of type signed int.
> > > + *
> > > + * writer An instance of a configuration writer.
> > > + *
> > > + * element_name Element name.
> > > + *
> > > + * value Signed int value of the element
> > > + *
> > > + * Returns zero if the element's value could be written.
> > > + * Negative values indicate an error.
> > > + */
> > > +LTTNG_HIDDEN
> > > +int mi_writer_write_element_signed_int(mi_writer *writer,
> > > +        const char *element_name, int64_t value);
> > > +
> > > +/*
> > > + * Write an element of type boolean.
> > > + *
> > > + * writer An instance of a configuration writer.
> > > + *
> > > + * element_name Element name.
> > > + *
> > > + * value Boolean value of the element
> > > + *
> > > + * Returns zero if the element's value could be written.
> > > + * Negative values indicate an error.
> > > + */
> > > +LTTNG_HIDDEN
> > > +int mi_writer_write_element_bool(mi_writer *writer,
> > > +        const char *element_name, int value);
> > > +
> > > +/*
> > > + * Write an element of type string.
> > > + *
> > > + * writer An instance of a configuration writer.
> > > + *
> > > + * element_name Element name.
> > > + *
> > > + * value String value of the element
> > > + *
> > > + * Returns zero if the element's value could be written.
> > > + * Negative values indicate an error.
> > > + */
> > > +LTTNG_HIDDEN
> > > +int mi_writer_write_element_string(mi_writer *writer,
> > > +        const char *element_name, const char *value);
> > > +
> > > +
> > > +#endif /* _MI_H */
> > > --
> > > 1.7.9.5
> > >
> > =

> > 2014-03-07 14:28 GMT-05:00 Jonathan Rajotte <jonathan.r.julien@gmail.co=
m>:
> > > Bonjour David, J=E9r=E9mie
> > >
> > > Voici un prototype de MI pour la commande version et list -k. Nous av=
ions
> > > plus cependant nous avons eu de la mis=E8re dans les deux derniers jo=
urs avec
> > > les test de r=E9gression ... mauvaise logistique de notre cot=E9. Ces=
 patchs
> > > sont bas=E9 sur la branche https://github.com/jgalar/lttng-tools save=
-restore
> > > de J=E9r=E9mie.
> > >
> > > Cela peux sembler peux cependant nous avons essayer de vous proposer =
de quoi
> > > qui, on l'esp=E8re, s'incorpore dans lttng correctement.. Nous avons
> > > probablement tord  mais bon ... On attend votre feedback.
> > >
> > > Concernant la gestion des erreurs, tel que discut=E9 avec J=E9r=E9mie=
, nous allons
> > > probablement output le mi dans un fichiers unique temporaire puis le
> > > rediriger vers stdout pour =E9viter du garbage en output. Je travaille
> > > activement sur cela en fds.
> > >
> > > Cependant vous comprendrez que avant d'aller plus loin, on voudrait q=
ue
> > > notre base soit valide. Nous sommes conscient de notre retard concern=
ant
> > > cela. On pr=E9voit mettre les bouch=E9s triples.
> > >
> > > Dans l'=E9ventualit=E9 que le travail effectu=E9 ne vous convient abs=
olument pas,
> > > j'aimerais que l'on puisse se rencontrer en personne/hangout/skype/ap=
pel
> > > conf=E9rence pour rem=E9dier rapidement =E0 la situation plut=F4t que=
 de faire cela
> > > via un =E9change d'email et de irc... Je suis conscient de la valeur =
de votre
> > > temps cependant je crois que cela r=E9glerais le probl=E8me plus rapi=
dement.
> > >
> > > Voil=E0, on attend de vos nouvelles.
> > >
> > > --
> > > Jonathan Rajotte Julien
> > > Charg=E9 de laboratoire, INF1995
> > > Polytechnique Montr=E9al
> > =

> > =

> > =

> > -- =

> > J=E9r=E9mie Galarneau
> > EfficiOS Inc.
> > http://www.efficios.com



-- =

Jonathan Rajotte Julien
Charg=E9 de laboratoire INF1995
Membre MD6
Polytechnique Montr=E9al
