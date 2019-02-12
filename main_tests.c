/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_tests.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bleplat <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/02/05 16:36:53 by bleplat           #+#    #+#             */
/*   Updated: 2019/02/05 19:38:55 by bleplat          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "tests.h"

int			main(int argc, char **argv)
{
	if (argc < 2)
		return (250);
#include "init.c"
	if (strcmp(argv[1], "printf") == 0)
		return (printf());
	else if (strcmp(argv[1], "ft_printf") == 0)
		return (ft_printf());
	else
		return (251);
}
