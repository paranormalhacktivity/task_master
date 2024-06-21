from setuptools import setup, find_packages

setup(
    name="task_master_py",
    author="Houston Knight",
    packages=find_packages(),
    extras_require={ "dev": ["pytest"] }
)
