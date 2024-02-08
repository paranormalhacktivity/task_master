# Multi-Language Project Task Tracker

This repository contains a command-line application for tracking project tasks, written in various programming languages. The application parses CSV data(with support for other data stores to come), allowing users to generate different reports based on their project tasks.

## Table of Contents

    Motivation
    Getting Started
    Usage
    Supported Languages
    Docker Support
    Directory Structure
    License

## Motivation
As a seasoned Ruby on Rails developer with several years of experience, I've had the privilege of working on a wide range of projects and applications. While Rails has been my go-to framework, I believe in the value of exploring new perspectives and technologies.

In my current role, I find myself deeply immersed in data analytics, working with large datasets from diverse organizations. This experience has not only honed my skills in data manipulation and analysis but also highlighted the importance of adaptability and versatility in the ever-evolving field of software development.

This project is a personal endeavor to broaden my horizons by delving into various programming languages and their respective ecosystems. By leveraging my familiarity with data analytics, I aim to gain fresh insights and approaches that I can bring back to my work as a Rails developer. Through this exploration, I hope to uncover new ways of solving problems and discover the unique strengths of each language.

I invite you to join me on this journey as I embark on the exciting challenge of reimagining a familiar task in different programming languages, all while gaining a deeper understanding of their strengths and nuances.

## Getting Started

To get started with this project, follow the instructions specific to the programming language you're interested in. Please refer to the README in the respective language directory for detailed setup and usage instructions.

## Usage

For detailed usage instructions, please refer to the `README.md` in the language-specific directories.

## Supported Languages

    Ruby
    Javascript

## Docker Support

You can also run this application using Docker. Refer to the Dockerfile for details on how to build and run the Docker image.

```
# Build Docker image
docker build -t task_master .

# Run Docker container
docker run -it task_master

# If changes have been made post-build, run docker container with a volume, to reflect changes, without having to rebuild
docker run --rm -it -v ${PWD}:/task_master
```

## Directory Structure

    `data/`: Contains data files that reporting can be dones on.
    `docs/`: Contains my personal, documented thoughts as I go through each language iteration of this project.
    `javascript/`: Contains the Javascript(NodeJS) version of the application.
    `ruby/`: Contains the Ruby version of the application.

## License
This project is licensed under the MIT License.
